defmodule PlainBenchmark.Instrumentation.OperationCounter do
  use GenServer

  @me __MODULE__

  def start_link(_args), do: GenServer.start_link(@me, 0, name: @me)

  def init(state), do: {:ok, state}

  def increment(), do: GenServer.call(@me, {:increment})

  def read(), do: GenServer.call(@me, {:read})

  def handle_call({:increment}, _from, state) do
    {:reply, :ok, state + 1}
  end

  def handle_call({:read}, _from, state) do
    {:reply, state, state}
  end
end
