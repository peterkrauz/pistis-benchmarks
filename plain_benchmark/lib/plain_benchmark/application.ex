defmodule PlainBenchmark.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [PlainBenchmark.Web]
    opts = [strategy: :one_for_one, name: PlainBenchmark.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
