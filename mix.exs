defmodule ExAliyun.OpenAPI.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_aliyun_openapi,
      version: "0.8.2",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: [extras: ["README.md"]],
      description: "Aliyun OpenAPI for elixir",
      source_url: "https://github.com/edragonconnect/ex_aliyun_openapi",
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {ExAliyun.OpenAPI.Application, []},
      extra_applications: [:logger]
    ]
  end

  def package do
    [
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/edragonconnect/ex_aliyun_openapi"}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.20", only: :dev, runtime: false},
      {:tesla, "~> 1.4"},
      {:finch, "~> 0.7"},
      {:jason, "~> 1.1"},
      {:timex, "~> 3.4"},
      {:elixir_uuid, "~> 1.2"}
    ]
  end
end
