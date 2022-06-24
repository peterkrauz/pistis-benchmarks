defmodule PistisBenchmark.Instrumentation.FileWriter do
  def write(content) do
    {:ok, file} = File.open(file_path(), [:append, {:delayed_write, 100, 20}])
    IO.binwrite(file, "\n#{content}")
    File.close(file)
  end

  def clean_file(), do: File.write!(file_path(), "")

  defp file_path(), do: "throughput_#{replica_count()}_replicas.txt"

  defp replica_count() do
    cluster_size = Application.get_env(:pistis, :cluster_size, 0)
    known_hosts = Application.get_env(:pistis, :known_hosts, [])
    max(cluster_size, length(known_hosts))
  end
end
