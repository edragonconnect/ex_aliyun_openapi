defmodule ExAliyun.OpenAPI.Application do
  @moduledoc false
  use Application

  def start(_type, _args) do
    app = Application.get_application(__MODULE__)
    size = Application.get_env(app, :pool_size, 32)
    count = Application.get_env(app, :pool_count, 8)

    children = [
      {Finch,
       name: ExAliyun.OpenAPI.Finch,
       pools: %{
         :default => [size: size, count: count]
       }}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExAliyun.OpenAPI.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
