defmodule XogmiosWatcher.ChainSyncClient do
  use Xogmios, :chain_sync

  require Logger

  def start_link(opts) do
    Xogmios.start_chain_sync_link(__MODULE__, opts)
  end

  @impl true
  def handle_block(block, state) do
    date_time = DateTime.utc_now() |> to_string |> String.slice(0..18)
    Logger.info("handle_block #{block["height"]} - #{date_time}")
    {:ok, :next_block, state}
  end
end
