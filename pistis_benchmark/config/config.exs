import Config

config :pistis_benchmark, port: 5456
config :pistis_benchmark, shutdown_in: 300000

config :pistis, machine: PistisBenchmark.KVStore
config :pistis, known_hosts: [
  :"pistis_node_1@10.10.1.3",
  :"pistis_node_2@10.10.1.4",
  :"pistis_node_3@10.10.1.5",
  :"pistis_node_4@10.10.1.6",
  :"pistis_node_5@10.10.1.7",
  :"pistis_node_6@10.10.1.8",
  :"pistis_node_7@10.10.1.9",
  :"pistis_node_8@10.10.1.10",
  :"pistis_node_9@10.10.1.11",
]
