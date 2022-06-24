import Config

config :load_generator, target_host: "localhost"
config :load_generator, target_port: 5456
config :load_generator, worker_count: 5
config :load_generator, heartbeat: 1
config :load_generator, shutdown_in: 180000
