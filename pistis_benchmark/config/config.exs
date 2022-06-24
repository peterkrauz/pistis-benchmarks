import Config

config :pistis_benchmark, port: 5456
config :pistis_benchmark, shutdown_in: 18000
config :pistis, machine: PistisBenchmark.KVStore
