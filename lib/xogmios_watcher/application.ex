defmodule XogmiosWatcher.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {XogmiosWatcher.ChainSyncClient, url: get_ogmios_url()},
      {XomgiosWatcher.TxSubmissionClient, url: get_ogmios_url()}
    ]

    opts = [strategy: :one_for_one, name: XogmiosWatcher.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp get_ogmios_url do
    System.fetch_env!("OGMIOS_URL")
  end
end
