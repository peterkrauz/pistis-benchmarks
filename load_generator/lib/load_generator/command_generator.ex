defmodule LoadGenerator.CommandGenerator do
  @alphabet 'abcdefghijklmnopqrstuvwxyz'

  def random_commands() do
    [
      [command: "get", args: [random_arg()]],
      [command: "get", args: [random_arg()]],
      [command: "put", args: [random_arg(), random_arg()]],
      [command: "put", args: [random_arg(), random_arg()]],
    ]
  end

  defp random_arg() do
    for _ <- 1..:rand.uniform(2), into: "", do: <<Enum.random(@alphabet)>>
  end
end
