defmodule LoadGenerator.CommandGenerator do
  def random_commands() do
    [
      [command: "get", args: ["a"]],
      [command: "get", args: [random_letter()]],
      [command: "get", args: [random_letter()]],
      [command: "put", args: ["a", 1]],
      [command: "put", args: [random_letter(), random_letter()]],
      [command: "put", args: [random_letter(), random_letter()]],
    ]
  end

  defp random_letter(), do: <<Enum.random('abcdefghijklmnopqrstuvwxyz')>>
end
