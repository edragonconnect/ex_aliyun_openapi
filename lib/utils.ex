defmodule ExAliyunOpenapi.Utils do
  @moduledoc """
  Utils for Aliyun OpenAPI.
  """

  def get_query(common_params, params, access_key_secret) do
    sign_params = common_params |> Map.merge(params)

    string_to_sign = format_string_to_sign(sign_params)

    signature = sign(access_key_secret, string_to_sign)

    sign_params
    |> Map.put("Signature", signature)
    |> Map.to_list()
  end

  def get_access_info(service) do
    Application.get_env(:ex_aliyun_openapi, service)
  end

  def sign(access_key_secret, string_to_sign) do
    access_key_secret = access_key_secret <> "&"

    :crypto.hmac(:sha, access_key_secret, string_to_sign)
    |> Base.encode64()
  end

  defp format_string_to_sign(params) do
    format_string =
      params
      |> Map.keys()
      |> Enum.sort()
      |> Enum.map(fn key ->
        "#{URI.encode(key, &URI.char_unreserved?/1)}=#{
          URI.encode(to_string(params[key]), &URI.char_unreserved?/1)
        }"
      end)
      |> Enum.join("&")
      |> URI.encode(&URI.char_unreserved?/1)

    "POST&%2F&" <> format_string
  end

  def get_timestamp do
    now = Timex.now()
    timestamp = now |> Timex.format!("%Y-%m-%dT%H:%M:%SZ", :strftime)
    signature_nonce = UUID.uuid1()

    {timestamp, signature_nonce}
  end
end
