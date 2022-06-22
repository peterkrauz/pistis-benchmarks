defmodule PistisBenchmark.Web do
  use Plug.Router
  alias Plug.Conn

  plug :match
  plug :dispatch

  def child_spec(_arg) do
    Plug.Adapters.Cowboy.child_spec(
      scheme: :http,
      plug: __MODULE__,
      options: [port: Application.fetch_env!(:pistis_benchmark, :port)],
    )
  end

  get "/benchmark" do
    conn
    |> Conn.put_resp_content_type("text/plain")
    |> Conn.send_resp(200, "ok from #{Node.self()} - pistis_benchmark")
  end
end
