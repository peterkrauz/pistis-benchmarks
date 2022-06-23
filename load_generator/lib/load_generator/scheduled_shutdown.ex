defmodule LoadGenerator.ScheduledShutdown do
  use GenServer

  @me __MODULE__
  @shutdown_in Application.fetch_env!(:load_generator, :shutdown_in)

  def start_link(args), do: GenServer.start_link(@me, args, name: @me)

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:shutdown, state) do
    IO.puts("Shutting down...")

    LoadGenerator.Supervisor
    |> Process.whereis()
    |> Process.exit(:kill)

    IO.puts("Load generation has stopped")

    {:noreply, state}
  end

  defp schedule_work(), do: Process.send_after(self(), :shutdown, @shutdown_in)
end
