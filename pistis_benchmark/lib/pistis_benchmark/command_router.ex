defmodule PistisBenchmark.CommandRouter do
  def route_to_machine(_command, args), do: machine_command_for_args(String.split(args, ","))

  defp machine_command_for_args([key]), do: TODO()
  defp machine_command_for_args([key, value]), do: TODO()
end
