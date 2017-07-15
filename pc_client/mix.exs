defmodule PcClient.Mixfile do
  use Mix.Project

  def project do
    [app: :pc_client,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      { :hangman, path: "../hangman" },
    ]
  end
end
