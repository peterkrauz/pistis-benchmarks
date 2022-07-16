defmodule LoadGenerator.Worker do
  @me __MODULE__

  @heartbeat Application.fetch_env!(:load_generator, :heartbeat)
  @target_host Application.fetch_env!(:load_generator, :target_host)
  @target_port Application.fetch_env!(:load_generator, :target_port)

  def start_link(args), do: GenServer.start_link(@me, args)

  def init(state) do
    LoadGenerator.ScheduledShutdown.start_link([])
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

  def request_url(), do: get_base_url() <> get_random_query_params()

  defp get_base_url(), do: "http://#{@target_host}:#{@target_port}/benchmark"

  defp get_random_query_params() do
    commands = LoadGenerator.CommandGenerator.random_commands()
    query_param = Enum.at(commands, :rand.uniform(length(commands) - 1))
    args = Keyword.get(query_param, :args) |> Enum.join(",")
    "?command=#{Keyword.get(query_param, :command)}&args=#{args}"
  end

  defp process_response({:ok, response}), do: Map.get(response, :body)

  defp process_response({:error, %HTTPoison.Error{id: _, reason: _}}) do
    IO.puts("Error ~> #{request_url()}")
  end

  defp write_to_file(content) do
    if LoadGenerator.WritePermission.can_write(self()) do
      LoadGenerator.FileWriter.write(content)
    end
  end
end
