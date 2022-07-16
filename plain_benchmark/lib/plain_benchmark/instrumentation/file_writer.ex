defmodule PlainBenchmark.Instrumentation.FileWriter do

  def write(content) do
    {:ok, file} = File.open(file_path(), [:append, {:delayed_write, 100, 20}])
    IO.binwrite(file, "\n#{:os.system_time(:millisecond)},#{content}")
    File.close(file)
  end

  defp file_path(), do: "throughput_#{client_count()}_clients.csv"

  def clean_file(), do: File.write!(file_path(), "")

  defp client_count() do
    Application.fetch_env!(:plain_benchmark, :worker_count)
  end
end
