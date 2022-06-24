defmodule PistisBenchmark.Boot do
  use Supervisor
  alias PistisBenchmark.Instrumentation

  def start_link(init_arg \\ []) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    children = [
      PistisBenchmark.Web,
      Instrumentation.OperationCounter,
      Instrumentation.ThroughputTracker,
      Instrumentation.ScheduledShutdown,
    ]
    Supervisor.init(children, strategy: :one_for_one, name: PistisBenchmark.Boot)
  end
end
