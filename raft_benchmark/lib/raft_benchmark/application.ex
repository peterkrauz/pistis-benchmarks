defmodule RaftBenchmark.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [RaftBenchmark.Web]
    opts = [strategy: :one_for_one, name: RaftBenchmark.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
