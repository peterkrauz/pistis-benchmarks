defmodule PistisBenchmark.Instrumentation.FileWriter do
  @file_path "throughput.txt"

  def write(content) do
    {:ok, file} = File.open(@file_path, [:append, {:delayed_write, 100, 20}])
    IO.binwrite(file, "\n#{content}")
    File.close(file)
  end

  def clean_file(), do: File.write!(@file_path, "")
end
