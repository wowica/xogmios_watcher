# XogmiosWatcher

Elixir application that follows the Cardano blockchain and prints new blocks to the console.

Requires a running [Ogmios](https://ogmios.dev/) instance. If you don't have access to one, then visit [Demeter.run](https://demeter.run/)

## Running

```
docker build -t xogmios-watcher .
docker run --env OGMIOS_URL="..." xogmios-watcher
```