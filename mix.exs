defmodule Docspring.Mixfile do
  use Mix.Project

  def project do
    [app: :docspring,
     version: "0.0.2",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     description: description(),
     package: package(),
     source_url: "https://github.com/DocSpring/docspring-elixir",
     docs: [
      main: "Docspring", # The main page in the docs
      logo: "../../../public/logo.png",
      authors: ["Nathan Broadbent"]
    ]]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  defp description() do
    "Elixir API client for the DocSpring PDF generation service"
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:tesla, "~> 0.8"},
      {:poison, ">= 1.0.0"}
    ]
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/DocSpring/docspring-elixir"}
    ]
  end
end
