defmodule Pinger.MixProject do
  use Mix.Project

  def project do
    [
      app: :pinger,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: "https://github.com/ryochin/pinger",
      docs: [main: "readme", extras: ["README.md"]]
    ]
  end

  def application, do: []

  defp deps do
    [
      {:credo, "~> 1.1.5", only: [:dev, :test]},
      {:dialyxir, "~> 1.0.0-rc.7", only: :dev, runtime: false},
      {:ex_doc, "~> 0.20", only: :dev},
      {:gen_icmp, github: "ryochin/gen_icmp"}
    ]
  end
end
