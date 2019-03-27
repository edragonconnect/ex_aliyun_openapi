defmodule ExAliyunOpenapi do
  @moduledoc """
  Documentation for ExAliyunOpenapi.
  """

  alias ExAliyunOpenapi.Http

  def call_cps(params) do
    Http.client(:cps, params)
    |> Http.post()
  end

  def call_sts(params) do
    Http.client(:sts, params)
    |> Http.post()
  end
end
