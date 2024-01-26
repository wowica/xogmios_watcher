# Stage 1: Build the release
FROM elixir:1.16 AS builder

# Set environment variables
ENV MIX_ENV=prod \
    LANG=C.UTF-8

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    inotify-tools \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create and set the working directory
WORKDIR /app

# Copy the project files into the container
COPY . .

# Install project dependencies
RUN mix local.rebar --force && \
    mix local.hex --force && \
    mix deps.get --only prod

# Compile the project
RUN mix compile

# Build the release
RUN mix release

# Stage 2: Create the release image
FROM debian:bullseye-20210902-slim AS release

# Install runtime dependencies
RUN apt-get update -y && apt-get install -y libstdc++6 openssl libncurses5 locales \
  && apt-get clean && rm -f /var/lib/apt/lists/*_*

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR "/app"
RUN chown nobody /app

# set runner ENV
ENV MIX_ENV="prod"

# Copy the release from the builder stage
COPY --from=builder /app/_build/prod/rel/xogmios_watcher /app

# Expose the necessary port(s)
EXPOSE 4001

# Start the application
CMD ["bin/xogmios_watcher", "start"]
