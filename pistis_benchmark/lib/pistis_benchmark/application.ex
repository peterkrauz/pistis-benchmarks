defmodule PistisBenchmark.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [PistisBenchmark.Web, Pistis.Core.Entrypoint]
    opts = [strategy: :one_for_one, name: PistisBenchmark.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
