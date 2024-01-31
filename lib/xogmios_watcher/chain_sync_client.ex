defmodule XogmiosWatcher.ChainSyncClient do
  use Xogmios, :chain_sync

  require Logger

  def start_link(opts) do
    opts = Keyword.merge(opts, restart: :permanent)
    Xogmios.start_chain_sync_link(__MODULE__, opts)
  end

  @impl true
  def handle_block(block, state) do
    date_time = DateTime.utc_now() |> to_string |> String.slice(0..18)
    Logger.info("handle_block #{block["height"]} - #{date_time}")
    {:ok, :next_block, state}
  end

  @impl true
  def handle_connect(state) do
    Logger.info("ChainSyncClient connecting #{inspect(state)}")
    {:ok, state}
  end

  @impl true
  def handle_disconnect(_reason, state) do
    # Attempt to terminate the process so that it's automatically restarted by the supervision
    # tree, thus yielding a new connection to be established
    pid = GenServer.whereis(self())
    Process.exit(pid, :kill)

    Logger.info("ChainSyncClient disconnecting #{inspect(state)}")
    :ok
  end
end
