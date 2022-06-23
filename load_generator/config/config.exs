import Config

config :load_generator, target_host: "localhost"
config :load_generator, target_port: 5454
config :load_generator, worker_count: 5
config :load_generator, heartbeat: 50
