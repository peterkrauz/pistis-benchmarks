import Config

config :pistis_benchmark, port: 5456
config :pistis_benchmark, shutdown_in: 300000
config :pistis_benchmark, worker_count: 2 #4#8#16#32#64

config :pistis, machine: PistisBenchmark.KVStore
config :pistis, known_hosts: [
  :"pistis_node_1@10.10.1.1",
  :"pistis_node_2@10.10.1.2",
  :"pistis_node_3@10.10.1.3",
]
