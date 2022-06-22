import Config

config :pistis_benchmark, port: 5456
config :pistis, native_cluster: false
config :pistis, machine: PistisBenchmark.KVStore
