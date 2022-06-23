defmodule RaftBenchmark.Application do
  use Application
  alias RaftBenchmark.Instrumentation

  @impl true
  def start(_type, _args) do
    children = [
      RaftBenchmark.Web,
      Instrumentation.OperationCounter,
      Instrumentation.ThroughputTracker,
      Instrumentation.ScheduledShutdown,
    ]
    opts = [strategy: :one_for_one, name: RaftBenchmark.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
