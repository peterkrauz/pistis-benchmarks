defmodule PlainBenchmarkTest do
  use ExUnit.Case
  doctest PlainBenchmark

  test "greets the world" do
    assert PlainBenchmark.hello() == :world
  end
end
