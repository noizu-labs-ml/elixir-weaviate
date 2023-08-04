defmodule Noizu.Weaviate.MixProject do
  use Mix.Project

  def project do
    [
      app: :noizu_weaviate,
      name: "Noizu Weaviate",
      description: description(),
      package: package(),
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  defp description() do
    "Weaviate Wrapper"
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{
        project: "https://github.com/noizu-labs/elixir-weaviate",
        noizu_labs: "https://github.com/noizu-labs",
        noizu_labs_machine_learning: "https://github.com/noizu-labs-ml",
        noizu_labs_scaffolding: "https://github.com/noizu-labs-scaffolding",
        developer_github: "https://github.com/noizu"
      }
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {
        Noizu.Weaviate.Application,
        []
      },
      extra_applications: [:logger, :finch, :jason]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:finch, "~> 0.15"},
      {:jason, "~> 1.2"}
      # Add other dependencies as needed
    ]
  end
end
