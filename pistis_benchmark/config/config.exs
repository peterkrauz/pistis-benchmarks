import Config

config :pistis_benchmark, port: 5456
config :pistis_benchmark, shutdown_in: 180000

config :pistis, machine: PistisBenchmark.KVStore
config :pistis, known_hosts: [
  :pistis_node_1@localhost,
  :pistis_node_2@localhost,
  :pistis_node_3@localhost,
  :pistis_node_4@localhost,
  :pistis_node_5@localhost,
]
