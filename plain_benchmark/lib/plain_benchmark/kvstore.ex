defmodule PlainBenchmark.KVStore do
  use GenServer
  import String

  @me __MODULE__

  def start_link(_args), do: GenServer.start_link(@me, %{}, name: @me)

  def init(state), do: {:ok, state}

  def get(key) when is_atom(key), do: perform_get(key)
  def get(key), do: perform_get(to_atom(key))
  defp perform_get(key) do
    PlainBenchmark.OperationCounter.increment()
    GenServer.call(@me, {:get, key})
  end

  def put(key, value) when is_atom(key), do: perform_put(key, value)
  def put(key, value), do: perform_put(to_atom(key), to_atom(value))
  defp perform_put(key, value) do
    PlainBenchmark.OperationCounter.increment()
    GenServer.call(@me, {:put, key, value})
  end

  def data() do
    PlainBenchmark.OperationCounter.increment()
    GenServer.call(@me, {:data})
  end

  def handle_call({:get, key}, _from, state) do
    {:reply, Map.get(state, key), state}
  end

  def handle_call({:put, key, value}, _from, state) do
    {:reply, :ok, Map.put(state, key, value)}
  end

  def handle_call({:data}, _from, state) do
    {:reply, Enum.zip(Map.keys(state), Map.values(state)), state}
  end
end
