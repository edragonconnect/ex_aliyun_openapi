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

  @doc """
  Funtion to call Aliyun Short Message Service(短信服务).
  You can read the doc in [https://help.aliyun.com/document_detail/101414.html?spm=a2c4g.11186623.6.624.4d3d30bbtYZP9D](https://help.aliyun.com/document_detail/101414.html?spm=a2c4g.11186623.6.624.4d3d30bbtYZP9D)
  """
  def call_sms(params) do
    Http.client(:sms, params)
    |> Http.post()
  end

  @doc """
  Funtion to call Global Aliyun Short Message Service(国际短信服务).
  You can read the doc in [https://www.alibabacloud.com/help/zh/doc-detail/106591.htm?spm=a2c63.p38356.b99.21.1bb57d908cOskx](https://www.alibabacloud.com/help/zh/doc-detail/106591.htm?spm=a2c63.p38356.b99.21.1bb57d908cOskx)
  """
  def call_global_sms(params) do
    Http.client(:global_sms, params)
    |> Http.post()
  end

  @doc """
  Funtion to call Aliyun Authenticate Sig Service(人机验证).
  You can read the doc in [https://help.aliyun.com/document_detail/66340.html](https://help.aliyun.com/document_detail/66340.html)
  """
  def call_afs(params) do
    Http.client(:afs, params)
    |> Http.post()
  end
end
