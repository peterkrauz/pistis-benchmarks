defmodule RaftBenchmark.CommandRouter do
  def route_to_machine(_command, args), do: machine_command_for_args(String.split(args, ","))

  defp machine_command_for_args([key]), do: send_command({:get, key})
  defp machine_command_for_args([key, value]), do: send_command({:put, key, value})

  defp send_command(command) do
    RaftBenchmark.Instrumentation.OperationCounter.increment()
    :ra.process_command(RaftBenchmark.Cluster.any_member(), command)
  end
end
