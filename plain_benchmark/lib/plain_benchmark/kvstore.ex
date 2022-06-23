defmodule PlainBenchmark.KVStore do
  use GenServer

  @me __MODULE__

  def start_link(args), do: GenServer.start_link(@me, args, name: @me)

  def init(state), do: {:ok, state}

  def get(key), do: GenServer.call(@me, {:get, key})

  def put(key, value), do: GenServer.call(@me, {:put, key, value})

  def handle_call({:get, key}, _from, state) do
    {:reply, Map.get(state, key), state}
  end

  def handle_call({:put, key, value}, _from, state) do
    {:reply, :ok, Map.put(state, key, value)}
  end
end
