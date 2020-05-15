defmodule ExAliyunOpenapi.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_aliyun_openapi,
      version: "0.4.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: [extras: ["README.md"]],
      description: "Aliyun openapi for elixir",
      source_url: "https://github.com/edragonconnect/ex_aliyun_openapi",
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
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
      {:tesla, "~> 1.3"},
      {:hackney, "~> 1.15"},
      {:jason, "~> 1.1"},
      {:timex, "~> 3.4"},
      {:elixir_uuid, "~> 1.2"}
    ]
  end
end
