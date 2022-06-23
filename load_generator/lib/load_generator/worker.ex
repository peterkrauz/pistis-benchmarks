defmodule LoadGenerator.Worker do
  @me __MODULE__

  @heartbeat 200
  @target_host Application.fetch_env!(:load_generator, :target_host)
  @target_port Application.fetch_env!(:load_generator, :target_port)

  def start_link(args), do: GenServer.start_link(@me, args)

  def init(state) do
    LoadGenerator.FileWriter.clean_file()
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    start_stamp = :os.system_time(:millisecond)
    HTTPoison.get(request_url()) |> process_response()
    end_stamp = :os.system_time(:millisecond)
    write_to_file(end_stamp - start_stamp)

    schedule_work()
    {:noreply, state}
  end

  defp schedule_work(), do: Process.send_after(self(), :work, @heartbeat)

  defp request_url(), do: "http://#{@target_host}:#{@target_port}/benchmark"

  defp process_response({:ok, response}), do: Map.get(response, :body)

  defp process_response({:error, %HTTPoison.Error{id: _, reason: reason}}) do
    IO.puts("Something went wrong when making a request ~> #{request_url()}. Error code: #{reason}")
  end

  defp write_to_file(content) do
    if LoadGenerator.Instrumentation.can_log(self()) do
      LoadGenerator.FileWriter.write(content)
    end
  end
end
