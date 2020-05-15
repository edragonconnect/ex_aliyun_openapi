defmodule ExAliyunOpenapi.Http do
  @moduledoc """
  Tesla clients for Aliyun OpenAPI.
  """
  use Tesla

  require Logger

  def client(:cps, params) do
    adapter = {Tesla.Adapter.Hackney, [recv_timeout: 30_000, ssl_options: [versions: [:'tlsv1.3', :'tlsv1.2']]]}

    Tesla.client(
      [
        {ExAliyunOpenapi.Middleware, service: :cps, params: params},
        Tesla.Middleware.FormUrlencoded
      ],
      adapter
    )
  end

  def client(:sts, params) do
    adapter = {Tesla.Adapter.Hackney, [recv_timeout: 30_000, ssl_options: [versions: [:'tlsv1.3', :'tlsv1.2']]]}

    Tesla.client(
      [
        {ExAliyunOpenapi.Middleware, service: :sts, params: params},
        Tesla.Middleware.FormUrlencoded
      ],
      adapter
    )
  end

  def client(:sms, params) do
    adapter = {Tesla.Adapter.Hackney, [recv_timeout: 30_000, ssl_options: [versions: [:'tlsv1.3', :'tlsv1.2']]]}

    Tesla.client(
      [
        {ExAliyunOpenapi.Middleware, service: :sms, params: params},
        Tesla.Middleware.FormUrlencoded
      ],
      adapter
    )
  end

  def client(:global_sms, params) do
    adapter = {Tesla.Adapter.Hackney, [recv_timeout: 30_000, ssl_options: [versions: [:'tlsv1.3', :'tlsv1.2']]]}

    Tesla.client(
      [
        {ExAliyunOpenapi.Middleware, service: :global_sms, params: params},
        Tesla.Middleware.FormUrlencoded
      ],
      adapter
    )
  end

  def post(client) do
    res = post(client, "/", [])
    case res do
      {:ok, _} -> 
        res
      error -> 
        Logger.error(fn -> "ExAliyunOpenapi error with client: #{inspect client} and error: #{inspect error}" end)
        error
    end
  end

end
