defmodule RaftBenchmark.KVStore do
  @behaviour :ra_machine

  @impl :ra_machine
  def init(_config), do: %{}

  @impl :ra_machine
  def apply(_command_metadata, {:get, key}, state) do
    {state, Map.get(state, key), []}
  end

  @impl :ra_machine
  def apply(_command_metadata, {:put, key, value}, state) do
    {Map.put(state, key, value), :ok, []}
  end

  @impl :ra_machine
  def apply(_command_metadata, {:data}, state) do
    data = Enum.zip(Map.keys(state), Map.values(state))
    {state, data, []}
  end
end
