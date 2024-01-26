# XogmiosWatcher

Elixir app that follows the Cardano blockchain and prints new blocks to the console.  

Requires a running [Ogmios](https://ogmios.dev/) instance.

## Running

```
docker build -t xogmios-watcher .
docker run --env OGMIOS_URL="..." xogmios-watcher
```