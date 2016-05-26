defmodule Vigil.Mixfile do
  use Mix.Project

  def project do
    [app: :vigil,
     version: "0.0.1",
     elixir: "~> 1.3-dev",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [mod: {Vigil, []},
     applications: [:logger, :httpotion]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:feeder_ex, "~> 0.0.2"},
     {:httpotion, github: "myfreeweb/httpotion"},
     {:exredis, "~> 0.2.4"},
     {:mailman, "~> 0.2.2"},
     {:slime, "~> 0.13.0"}]
  end
end
