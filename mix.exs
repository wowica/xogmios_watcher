defmodule XogmiosWatcher.MixProject do
  use Mix.Project

  def project do
    [
      app: :xogmios_watcher,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {XogmiosWatcher.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:xogmios, github: "wowica/xogmios", ref: "1b9a106"},
      {:bech32, "~> 1.0"},
      {:blake2, "~> 1.0"}
    ]
  end
end
