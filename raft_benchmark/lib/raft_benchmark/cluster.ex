defmodule RaftBenchmark.Cluster do
  def connect_replicas() do
    # Demands that other BEAM instances ([:raft_node_1@localhost, :raft_node_2@localhost, ...]) have been created.
    replicas = Node.list()
    |> Enum.filter(&is_raft_replica/1)
    |> Enum.map(&start_raft/1)

    :timer.sleep(3500)

    raft_server_ids = replicas |> Enum.map(&to_raft_id/1)
    :ra.start_cluster(:default, cluster_name(), machine_spec(), raft_server_ids)
  end

  defp is_raft_replica(replica_address) do
    Atom.to_string(node) |> String.contains?("raft_node")
  end

  defp start_raft(replica_address) do
    :rpc.call(replica, :ra, :start, [])
    replica_address
  end

  defp to_raft_id(replica_address), do: {cluster_name(), replica_address}

  defp cluster_name(), do: :raft

  defp machine_spec(), do: {:module, RaftBenchmark.KVStore, %{}}

  def raft_leader() do
    {:ok, members, leader} = :ra.members({cluster_name(), :raft_node_1@localhost})
    leader
  end
end
