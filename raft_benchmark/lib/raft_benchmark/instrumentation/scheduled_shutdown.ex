defmodule RaftBenchmark.Instrumentation.ScheduledShutdown do
  use GenServer

  @me __MODULE__

  @shutdown_in Application.fetch_env!(:raft_benchmark, :shutdown_in)

  def start_link(args), do: GenServer.start_link(@me, args, name: @me)

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:shutdown, state) do
    target_module = RaftBenchmark.Supervisor
    IO.puts("Shutting down #{target_module}")

    target_module
    |> Process.whereis()
    |> Process.exit(:kill)

    IO.puts("#{target_module} has been shut down")

    {:noreply, state}
  end

  defp schedule_work(), do: Process.send_after(self(), :shutdown, @shutdown_in)
end
