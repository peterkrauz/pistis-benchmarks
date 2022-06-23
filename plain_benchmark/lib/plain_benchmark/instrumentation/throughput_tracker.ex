defmodule PlainBenchmark.Instrumentation.ThroughputTracker do
  use GenServer
  alias PlainBenchmark.Instrumentation

  @me __MODULE__
  @heartbeat 1000

  def start_link(_args), do: GenServer.start_link(@me, 0, name: @me)

  def init(state) do
    Instrumentation.FileWriter.clean_file()
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, last_ops_counter) do
    new_ops_counter = Instrumentation.OperationCounter.read()
    Instrumentation.FileWriter.write(new_ops_counter - last_ops_counter)
    schedule_work()
    {:noreply, new_ops_counter}
  end

  defp schedule_work(), do: Process.send_after(self(), :work, @heartbeat)
end
