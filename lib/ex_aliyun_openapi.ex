defmodule ExAliyunOpenapi do
  @moduledoc """
  Functions to call aliyun openapi.
  * Common args are added by ExAliyunOpenapi.Middleware.
  * You can just put addition args.
  * You can find the api params in [https://help.aliyun.com](https://help.aliyun.com).
  """

  alias ExAliyunOpenapi.Http

  @doc """
  Function to call Aliyun Cloud Push Service(移动推送).
  You can read the doc in [https://help.aliyun.com/document_detail/48038.html](https://help.aliyun.com/document_detail/48038.html).
  """
  def call_cps(params) do
    Http.client(:cps, params)
    |> Http.post()
  end

  @doc """
  Function to call Aliyun Security Token Service(短期访问权限).
  You can read the doc in [https://help.aliyun.com/document_detail/28576.html](https://help.aliyun.com/document_detail/28576.html).
  """
  def call_sts(params) do
    Http.client(:sts, params)
    |> Http.post()
  end
end
