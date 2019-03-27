defmodule ExAliyunOpenapi.Http do
  @moduledoc false

  use Tesla

  def client(:cps, params) do
    Tesla.client([
      {ExAliyunOpenapi.Middleware, service: :cps, params: params}
    ])
  end

  def client(:sts, params) do
    Tesla.client([
      {ExAliyunOpenapi.Middleware, service: :sts, params: params}
    ])
  end

  def client(:sms, params) do
    Tesla.client([
      {ExAliyunOpenapi.Middleware, service: :sms, params: params}
    ])
  end

  def post(client) do
    post(client, "/", [])
  end
end
