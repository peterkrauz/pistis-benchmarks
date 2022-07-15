import Config

config :raft_benchmark, port: 5455
config :raft_benchmark, cluster_size: 3 # 6 # 9
config :raft_benchmark, shutdown_in: 300000
config :raft_benchmark, worker_count: 2 #4#8#16#32#64
