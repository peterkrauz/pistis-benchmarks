defmodule PistisBenchmark.Instrumentation.FileWriter do
  def write(content) do
    {:ok, file} = File.open(file_path(), [:append, {:delayed_write, 100, 20}])
    IO.binwrite(file, "\n#{:os.system_time(:millisecond)},#{content}")
    File.close(file)
  end

  def clean_file(), do: File.write!(file_path(), "")

  defp file_path(), do: "throughput_#{client_count()}_clients_#{replica_count()}_replicas.csv"

  defp replica_count() do
    cluster_size = Application.get_env(:pistis, :cluster_size, 0)
    known_hosts = Application.get_env(:pistis, :known_hosts, [])
    max(cluster_size, length(known_hosts))
  end

  defp client_count() defmodule RaftBenchmark.Instrumentation.FileWriter do
    Application.fetch_env!(:pistis_benchmark, :worker_count)
  end
end
