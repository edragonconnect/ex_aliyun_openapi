defmodule ExAliyunOpenapi.Http do
  @moduledoc """
  Tesla clients for Aliyun OpenAPI.
  """

  use Tesla

  def client(:cps, params) do
    Tesla.client([
      {ExAliyunOpenapi.Middleware, service: :cps, params: params},
      Tesla.Middleware.FormUrlencoded
    ])
  end

  def client(:sts, params) do
    adapter = {Tesla.Adapter.Mint, [timeout: 30_000]}
    Tesla.client([
      {ExAliyunOpenapi.Middleware, service: :sts, params: params},
      Tesla.Middleware.FormUrlencoded],
      adapter)
  end

  def client(:sms, params) do
    Tesla.client([
      {ExAliyunOpenapi.Middleware, service: :sms, params: params},
      Tesla.Middleware.FormUrlencoded
    ])
  end

  def post(client) do
    post(client, "/", [])
  end
end
