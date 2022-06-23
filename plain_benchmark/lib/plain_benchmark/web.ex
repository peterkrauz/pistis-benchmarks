defmodule PlainBenchmark.Web do
  use Plug.Router
  alias Plug.Conn

  plug :match
  plug :dispatch

  def child_spec(_arg) do
    Plug.Adapters.Cowboy.child_spec(
      scheme: :http,
      plug: __MODULE__,
      options: [port: Application.fetch_env!(:plain_benchmark, :port)],
    )
  end

  get "/benchmark" do
    conn = Plug.Conn.fetch_query_params(conn)
    query_params = conn.params

    command = Map.get(query_params, "command")
    args = Map.get(query_params, "args")

    IO.puts("Got command: #{command}")
    IO.puts("Got args: #{args}")

    conn
    |> Conn.put_resp_content_type("text/plain")
    |> Conn.send_resp(200, "ok from #{Node.self()} - plain_benchmark")
  end
end
