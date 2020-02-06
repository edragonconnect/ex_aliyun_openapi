defmodule ExAliyunOpenapi.Middleware do
  @moduledoc """
  Middlewares for Aliyun OpenAPI.
  * Common args are added in middlewares. You should pass addition args by ExAliyunOpenapi functions.
  """

  @behaviour Tesla.Middleware

  alias ExAliyunOpenapi.Utils

  def call(env, next, opts) do
    service = Keyword.get(opts, :service)
    params = Keyword.get(opts, :params)

    env
    |> prepare_request(service, params)
    |> Tesla.run(next)
    |> decode_response()
  end

  defp prepare_request(env, :cps, params) do
    access_info = Utils.get_access_info(:cps)
    access_key_id = Keyword.get(access_info, :access_key_id)
    access_key_secret = Keyword.get(access_info, :access_key_secret)
    {timestamp, signature_nonce} = Utils.get_timestamp()

    common_params = %{
      "Format" => "JSON",
      "RegionId" => "cn-hangzhou",
      "Version" => "2016-08-01",
      "AccessKeyId" => access_key_id,
      "Timestamp" => timestamp,
      "SignatureMethod" => "HMAC-SHA1",
      "SignatureVersion" => "1.0",
      "SignatureNonce" => signature_nonce
    }

    query = Utils.get_query(common_params, params, access_key_secret)

    env
    |> Tesla.put_body(query)
    |> Map.put(:url, "https://cloudpush.aliyuncs.com")
  end

  defp prepare_request(env, :sts, params) do
    access_info = Utils.get_access_info(:sts)
    access_key_id = Keyword.get(access_info, :access_key_id)
    access_key_secret = Keyword.get(access_info, :access_key_secret)
    {timestamp, signature_nonce} = Utils.get_timestamp()

    common_params = %{
      "Format" => "JSON",
      "Version" => "2015-04-01",
      "AccessKeyId" => access_key_id,
      "Timestamp" => timestamp,
      "SignatureMethod" => "HMAC-SHA1",
      "SignatureVersion" => "1.0",
      "SignatureNonce" => signature_nonce
    }

    query = Utils.get_query(common_params, params, access_key_secret)

    env
    |> Map.put(:query, query)
    |> Map.put(:url, "https://sts.aliyuncs.com")
  end

  defp prepare_request(env, :sms, params) do
    access_info = Utils.get_access_info(:sms)
    access_key_id = Keyword.get(access_info, :access_key_id)
    access_key_secret = Keyword.get(access_info, :access_key_secret)
    {timestamp, signature_nonce} = Utils.get_timestamp()

    common_params = %{
      "Format" => "JSON",
      "Version" => "2017-05-25",
      "AccessKeyId" => access_key_id,
      "Timestamp" => timestamp,
      "SignatureMethod" => "HMAC-SHA1",
      "SignatureVersion" => "1.0",
      "SignatureNonce" => signature_nonce,
      "RegionId" => "cn-hangzhou"
    }

    query = Utils.get_query(common_params, params, access_key_secret)

    env
    |> Map.put(:query, query)
    |> Map.put(:url, "https://dysmsapi.aliyuncs.com")
  end

  defp decode_response(env) do
    case env do
      {:ok, %Tesla.Env{status: 200, body: body}} ->
        {:ok, Jason.decode!(body)}

      {:ok, %Tesla.Env{status: code, body: body}} ->
        {:error, "error_code: #{code}, msg: #{body}"}

      error ->
        error
    end
  end
end
