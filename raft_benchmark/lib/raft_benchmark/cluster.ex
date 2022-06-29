defmodule RaftBenchmark.Cluster do
  @cluster_size Application.fetch_env!(:raft_benchmark, :cluster_size)

  def boot_replicas() do
    connect_replicas()
    replicas = get_raft_replicas()

    :timer.sleep(3500)

    raft_server_ids = replicas |> Enum.map(&to_raft_id/1)
    IO.puts("Raft server IDs:")
    raft_server_ids |> Enum.map(fn {a, b} -> IO.puts("{#{Atom.to_string(a)}, #{Atom.to_string(b)}}") end)
    :ra.start_cluster(:default, cluster_name(), machine_spec(), raft_server_ids)
  end

  def connect_replicas() do
    Range.new(1, @cluster_size)
    |> Enum.map(fn index -> connect_to_replica(index) end)
    |> Enum.map(&Node.connect/1)
  end

  def connect_to_replica(index) do
    address = "raft_node_#{index}@10.10.1.#{index + 1}"
    IO.puts("Connecting to #{address}")
    String.to_atom(address)
  end

  def get_raft_replicas() do
    replicas = Node.list()
    |> Enum.filter(&is_raft_replica/1)
    |> Enum.map(&start_raft/1)
  end

  def is_raft_replica(replica_address) do
    Atom.to_string(replica_address) |> String.contains?("raft_node")
  end

  def start_raft(replica_address) do
    :rpc.call(replica_address, :ra, :start, [])
    replica_address
  end

  defp to_raft_id(replica_address) do
    IO.puts("to_raft_id: #{replica_address} ~> #{inspect({cluster_name(), replica_address})}")
    {cluster_name(), replica_address}
  end

  defp cluster_name(), do: :raft

  defp machine_spec(), do: {:module, RaftBenchmark.KVStore, %{}}

  def raft_leader() do
    {:ok, _, leader} = :ra.members({cluster_name(), :"primary@10.10.1.2"})
    leader
  end

  def any_member() do
    {:ok, members, _} = :ra.members({cluster_name(), :"primary@10.10.1.2"})
    Enum.at(members, :rand.uniform(length(members) - 1))
  end
end
