import Config

config :load_generator, target_host: "10.10.1.1"
config :load_generator, target_port: 5455
config :load_generator, worker_count: 2 #4#8#16#32#64
config :load_generator, heartbeat: 50
config :load_generator, shutdown_in: 300000
