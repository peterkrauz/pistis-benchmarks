defmodule PlainBenchmark.Application do
  use Application
  alias PlainBenchmark.Instrumentation

  @impl true
  def start(_type, _args) do
    children = [
      PlainBenchmark.Web,
      PlainBenchmark.KVStore,
      Instrumentation.OperationCounter,
      Instrumentation.ThroughputTracker,
      Instrumentation.ScheduledShutdown,
    ]
    opts = [strategy: :one_for_one, name: PlainBenchmark.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
