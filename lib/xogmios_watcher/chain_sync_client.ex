defmodule XogmiosWatcher.ChainSyncClient do
  use Xogmios, :chain_sync

  require Logger

  def start_link(opts) do
    opts = Keyword.merge(opts, restart: :permanent)
    Xogmios.start_chain_sync_link(__MODULE__, opts)
  end

  @doc """
  Callback function that is invoked upon each new block
  """
  @impl true
  def handle_block(block, state) do
    issuer_vk = block["issuer"]["verificationKey"]
    pool_id = XogmiosWatcher.from_vk_to_bech32_pool_id(issuer_vk)

    Logger.info("Block #{block["height"]} issued by #{pool_id}")

    {:ok, :next_block, state}
  end

  @doc """
  Callback function that is invoked upon connecting to the Ogmios server
  """
  @impl true
  def handle_connect(state) do
    Logger.info("ChainSyncClient connecting #{inspect(state)}")
    Logger.info("Connecting at #{unix_now()}")

    {:ok, state}
  end

  @doc """
  Callback function that is invoked upon disconnection from the Ogmios server
  """
  @impl true
  def handle_disconnect(_reason, state) do
    Logger.info("ChainSyncClient disconnecting #{inspect(state)}")
    Logger.info("Disconneting at #{unix_now()}")

    # Attempt to reconnect in 15s
    {:reconnect, 15_000, state}
  end

  defp unix_now do
    DateTime.utc_now()
    |> DateTime.to_unix()
  end
end
