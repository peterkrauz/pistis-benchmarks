defmodule LoadGenerator.Application do
  @moduledoc false
  use Application
  alias LoadGenerator.Worker

  @impl true
  def start(_type, _args) do
    children = [:poolboy.child_spec(:worker, poolboy_config())]
    opts = [strategy: :one_for_one, name: LoadGenerator.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp poolboy_config() do
    [
      name: {:local, :worker},
      worker_module: Worker,
      size: Application.fetch_env!(:load_generator, :worker_count),
      max_overflow: Application.fetch_env!(:load_generator, :worker_count),
    ]
  end
end
