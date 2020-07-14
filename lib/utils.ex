defmodule ExAliyun.OpenAPI.Utils do
  @moduledoc """
  Utils for Aliyun OpenAPI.
  """

  def append_signature(common_params, params, access_key_secret) do
    sign_params = common_params |> Map.merge(params)

    string_to_sign = format_string_to_sign(sign_params)

    signature = sign(access_key_secret, string_to_sign)

    Map.put(sign_params, "Signature", signature)
  end

  @compile {:inline, sign: 2}
  def sign(access_key_secret, string_to_sign) do
    :crypto.hmac(:sha, access_key_secret <> "&", string_to_sign)
    |> Base.encode64()
  end

  def format_string_to_sign(params) do
    format_string =
      params
      |> Enum.sort()
      |> Stream.map(fn {key, value} ->
        URI.encode(key, &URI.char_unreserved?/1) <>
          "=" <>
          URI.encode(value, &URI.char_unreserved?/1)
      end)
      |> Enum.join("&")
      |> URI.encode(&URI.char_unreserved?/1)

    "POST&%2F&" <> format_string
  end
end
