import Config

config :pistis_benchmark, port: 5456
config :pistis_benchmark, shutdown_in: 300000

config :pistis, machine: PistisBenchmark.KVStore
config :pistis, known_hosts: [
  :"pistis_node_1@ip",
  :"pistis_node_2@ip",
  :"pistis_node_3@ip",
  :"pistis_node_4@ip",
  :"pistis_node_5@ip",
]
