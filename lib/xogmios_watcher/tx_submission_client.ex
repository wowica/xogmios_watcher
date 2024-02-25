defmodule XomgiosWatcher.TxSubmissionClient do
  use Xogmios, :tx_submission
  alias Xogmios.TxSubmission

  def start_link(opts) do
    Xogmios.start_tx_submission_link(__MODULE__, opts)
  end

  def submit_tx(pid \\ __MODULE__, cbor) do
    TxSubmission.submit_tx(pid, cbor)
  end

  def evaluate_tx(pid \\ __MODULE__, cbor) do
    TxSubmission.evaluate_tx(pid, cbor)
  end
end
