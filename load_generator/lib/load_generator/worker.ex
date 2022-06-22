defmodule LoadGenerator.Worker do
  @me __MODULE__

  @heartbeat 200
  @target_host Application.fetch_env!(:load_generator, :target_host)
  @target_port Application.fetch_env!(:load_generator, :target_port)

  def start_link(args), do: GenServer.start_link(@me, args)

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    # Alternative would be: :os.system_time(:millisecond)
    start_stamp = DateTime.utc_now()

    HTTPoison.get(request_url())
    |> process_response()

    end_stamp = DateTime.utc_now()
    diff = DateTime.diff(end_stamp, start_stamp)

    if LoadGenerator.Instrumentation.can_log(self()) do

    end

    schedule_work()
    {:noreply, state}
  end

  def handle_info(_, _) do
    :ok
  end

  defp schedule_work(), do: Process.send_after(self(), :work, @heartbeat)

  defp request_url(), do: "http://#{@target_host}:#{@target_port}/benchmark"

  def process_response({:ok, response}) do
    result = Map.get(response, :body)
    IO.puts("Got '#{result}' from url #{request_url()}")
  end

  def process_response({:error, %HTTPoison.Error{id: _, reason: reason}}) do
    IO.puts("Something went wrong when making a request ~> #{request_url()}. Error code: #{reason}")
  end
end
