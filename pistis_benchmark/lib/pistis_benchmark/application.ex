defmodule PistisBenchmark.Application do
  use Application
  alias PistisBenchmark.Instrumentation

  @impl true
  def start(_type, _args) do
    children = [
      PistisBenchmark.Web,
      Pistis.Core.Entrypoint,
      Instrumentation.OperationCounter,
      Instrumentation.ThroughputTracker,
      Instrumentation.ScheduledShutdown,
    ]
    opts = [strategy: :one_for_one, name: PistisBenchmark.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
