defmodule Vigil.Mixfile do
  use Mix.Project

  @version "0.4.0"

  def project do
    [
      app: :vigil,
      version: @version,
      elixir: "~> 1.7.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [mod: {Vigil, []},
      extra_applications: [
        :logger, :xmerl
      ]
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
    [
      {:feeder_ex, "~> 1.1.0"},
      {:httpotion, "~> 3.0.3"},
      {:exredis, "~> 0.2.5"},
      {:bamboo_smtp, "~> 1.4.0"},
      {:quantum, "~> 2.2.0"},
      {:timex, "~> 3.0"},
      {:oauther, "~> 1.1"},
      {:extwitter, "~> 0.9.1"},

      # Build and Deployment
      {:edeliver, "~> 1.4.4"},
      {:distillery, "~> 1.5.5"}
    ]
  end
end
