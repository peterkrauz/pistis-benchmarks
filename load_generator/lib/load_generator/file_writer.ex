defmodule LoadGenerator.FileWriter do
  @target_port Application.fetch_env!(:load_generator, :target_port)
  @worker_count Application.fetch_env!(:load_generator, :worker_count)

  def write(content) do
    {:ok, file} = File.open(file_path(), [:append, {:delayed_write, 100, 20}])
    IO.binwrite(file, "\n#{:os.system_time(:millisecond)}, #{content}")
    File.close(file)
  end

  def clean_file(), do: File.write!(file_path(), "")

  defp file_path(), do: "latency_#{@worker_count}_clients_port_#{@target_port}.csv"
end
