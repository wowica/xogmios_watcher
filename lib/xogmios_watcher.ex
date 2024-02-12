defmodule XogmiosWatcher do
  @moduledoc false

  @doc """
  Converts a pool verification key to
  its human readable bech32 id
  """
  def from_vk_to_bech32_pool_id(pool_vrf) do
    case Base.decode16(pool_vrf, case: :lower) do
      {:ok, bytes} ->
        hashed = Blake2.hash2b(bytes, 28)
        Bech32.encode("pool", hashed)

      :error ->
        IO.puts("Error decoding hex string")
        ""
    end
  end
end
