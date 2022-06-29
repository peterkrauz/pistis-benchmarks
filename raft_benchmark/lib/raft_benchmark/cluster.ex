defmodule RaftBenchmark.Cluster do
  @cluster_size Application.fetch_env!(:raft_benchmark, :cluster_size)

  def connect_replicas() do
    # Demands that other BEAM instances ([:raft_node_1@localhost, :raft_node_2@localhost, ...]) have been created.
    # Range.new(1, @cluster_size)
    # |> Enum.map(fn index -> :"raft_node_#{index}@127.0.0.1" end)
    # |> Enum.map(&Node.connect/1)

    replicas = Node.list()
    |> Enum.filter(&is_raft_replica/1)
    |> Enum.map(&start_raft/1)

    :timer.sleep(3500)

    raft_server_ids = replicas |> Enum.map(&to_raft_id/1)
    :ra.start_cluster(:default, cluster_name(), machine_spec(), raft_server_ids)
  end

  defp is_raft_replica(replica_address) do
    Atom.to_string(replica_address) |> String.contains?("raft_node")
  end

  defp start_raft(replica_address) do
    :rpc.call(replica_address, :ra, :start, [])
    replica_address
  end

  defp to_raft_id(replica_address), do: {cluster_name(), replica_address}

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
