defmodule PlainBenchmark.CommandRouter do
  alias PlainBenchmark.KVStore

  def route_to_machine(_command, args), do: machine_command_for_args(String.split(args, ","))

  defp machine_command_for_args([key]), do: KVStore.get(key)
  defp machine_command_for_args([key, value]), do: KVStore.put(key, value)
end
