defmodule ElixirBasics.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_basics,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {ElixirBasics, []},
      applications: [:cowboy],
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, github: "ninenines/cowboy", tag: "2.3.0"},
      {:poison, "~> 3.1"},
      {:uuid, "~> 1.1"}
    ]
  end
end
