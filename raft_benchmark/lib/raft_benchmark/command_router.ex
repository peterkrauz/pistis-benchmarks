defmodule RaftBenchmark.CommandRouter do
  def route_to_machine(_command, args), do: machine_command_for_args(String.split(args, ","))

  defp machine_command_for_args([key]), do: send_command({:get, key})
  defp machine_command_for_args([key, value]), do: send_command({:put, key, value})

  defp send_command(command) do
    :ra.process_command(RaftBenchmark.Cluster.raft_leader(), command)
  end
end
