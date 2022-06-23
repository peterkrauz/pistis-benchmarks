defmodule PlainBenchmark.CommandRouter do
  alias PlainBenchmark.KVStore

  def route_to_machine(_command, args), do: gambiarra_neles(String.split(args, ","))

  defp gambiarra_neles([key]), do: KVStore.get(key)
  defp gambiarra_neles([key, value]), do: KVStore.put(key, value)
end
