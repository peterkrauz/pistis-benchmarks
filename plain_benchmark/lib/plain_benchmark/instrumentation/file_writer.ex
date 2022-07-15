defmodule PlainBenchmark.Instrumentation.FileWriter do

  def write(content) do
    {:ok, file} = File.open(file_path(), [:append, {:delayed_write, 100, 20}])
    IO.binwrite(file, "\n#{:calendar.universal_time()},#{content}")
    File.close(file)
  end

  defp file_path(), do: "throughput_#{client_count()}_clients.csv"

  def clean_file(), do: File.write!(file_path(), "")

  defp client_count() defmodule RaftBenchmark.Instrumentation.FileWriter do
    Application.fetch_env!(:plain_benchmark, :worker_count)
  end
end
