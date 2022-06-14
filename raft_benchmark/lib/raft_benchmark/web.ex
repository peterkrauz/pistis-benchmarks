defmodule RaftBenchmark.Web do
  use Plug.Router

  plug :match
  plug :dispatch

  def child_spec(_arg) do
    Plug.Adapters.Cowboy.child_spec(
      scheme: :http,
      plug: __MODULE__,
      options: [port: Application.fetch_env!(:raft_benchmark, :port)],
    )
  end

  post "/some-url" do
    # TODO
  end
end
