defmodule PistisBenchmark.MixProject do
  use Mix.Project

  def project do
    [
      app: :pistis_benchmark,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {PistisBenchmark.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "~> 1.13"},
      {:cowboy, "~> 2.9"},
      {:plug_cowboy, "~> 2.0"},

      # Benchmark-specific
      {:pistis, "~> 0.1.3"},
    ]
  end
end
