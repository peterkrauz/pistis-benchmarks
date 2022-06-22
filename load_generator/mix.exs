defmodule LoadGenerator.MixProject do
  use Mix.Project

  def project do
    [
      app: :load_generator,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {LoadGenerator.Application, []}
    ]
  end

  defp deps do
    [
      {:poison, "~> 5.0"},
      {:httpoison, "~> 1.8"},
      {:poolboy, "~> 1.5.1"},
    ]
  end
end
