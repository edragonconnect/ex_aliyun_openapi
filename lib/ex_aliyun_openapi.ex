defmodule ExAliyun.OpenAPI do
  @moduledoc """
  Functions to call Aliyun OpenAPI.
  * You can just put addition args.
  * You can find the api params in [Official Link](https://help.aliyun.com).
  """

  use Tesla, only: [:post]
  alias ExAliyun.OpenAPI.Utils

  adapter({Tesla.Adapter.Finch, [name: ExAliyun.OpenAPI.Finch, receive_timeout: 30_000]})
  plug(Tesla.Middleware.Logger)
  plug(Tesla.Middleware.FormUrlencoded)
  plug(Tesla.Middleware.DecodeJson)

  @compile {:inline, get_access_info: 1}
  def get_access_info(service) do
    Application.get_env(:ex_aliyun_openapi, service)
  end

  @compile {:inline, get_timestamp: 0}
  def get_timestamp do
    Timex.now()
    |> Timex.lformat!("%FT%TZ", "en", :strftime)
  end

  @doc """
  Aliyun Cloud Push Service(移动推送).
  You can read the doc in [Official Link](https://help.aliyun.com/document_detail/48038.html).
  """
  def call_cps(params, access_info \\ nil) do
    access_info = with nil <- access_info, do: get_access_info(:cps)
    access_key_id = Keyword.get(access_info, :access_key_id)
    access_key_secret = Keyword.get(access_info, :access_key_secret)

    params =
      %{
        "Format" => "JSON",
        "RegionId" => "cn-hangzhou",
        "Version" => "2016-08-01",
        "SignatureMethod" => "HMAC-SHA1",
        "SignatureVersion" => "1.0",
        "AccessKeyId" => access_key_id,
        "Timestamp" => get_timestamp(),
        "SignatureNonce" => UUID.uuid1()
      }
      |> Utils.append_signature(params, access_key_secret)

    post("https://cloudpush.aliyuncs.com", params)
  end

  @doc """
  Aliyun Security Token Service(短期访问权限).
  You can read the doc in [Official Link](https://help.aliyun.com/document_detail/28576.html).
  """
  def call_sts(params, access_info \\ nil) do
    access_info = with nil <- access_info, do: get_access_info(:sts)
    access_key_id = Keyword.get(access_info, :access_key_id)
    access_key_secret = Keyword.get(access_info, :access_key_secret)

    params =
      %{
        "Format" => "JSON",
        "Version" => "2015-04-01",
        "SignatureMethod" => "HMAC-SHA1",
        "SignatureVersion" => "1.0",
        "AccessKeyId" => access_key_id,
        "Timestamp" => get_timestamp(),
        "SignatureNonce" => UUID.uuid1()
      }
      |> Utils.append_signature(params, access_key_secret)

    post("https://sts.aliyuncs.com", params)
  end

  @doc """
  Aliyun Short Message Service(短信服务).
  You can read the doc in [Official Link](https://help.aliyun.com/document_detail/101414.html).
  """
  def call_sms(params, access_info \\ nil) do
    access_info = with nil <- access_info, do: get_access_info(:sms)
    access_key_id = Keyword.get(access_info, :access_key_id)
    access_key_secret = Keyword.get(access_info, :access_key_secret)

    params =
      %{
        "Format" => "JSON",
        "Version" => "2017-05-25",
        "SignatureMethod" => "HMAC-SHA1",
        "SignatureVersion" => "1.0",
        "RegionId" => "cn-hangzhou",
        "AccessKeyId" => access_key_id,
        "Timestamp" => get_timestamp(),
        "SignatureNonce" => UUID.uuid1()
      }
      |> Utils.append_signature(params, access_key_secret)

    post("https://dysmsapi.aliyuncs.com", params)
  end

  @doc """
  Global Aliyun Short Message Service(国际短信服务).
  You can read the doc in [Official Link](https://www.alibabacloud.com/help/zh/doc-detail/106591.htm).
  """
  def call_global_sms(params, access_info \\ nil) do
    access_info = with nil <- access_info, do: get_access_info(:global_sms)
    access_key_id = Keyword.get(access_info, :access_key_id)
    access_key_secret = Keyword.get(access_info, :access_key_secret)

    params =
      %{
        "Format" => "JSON",
        "Version" => "2018-05-01",
        "SignatureMethod" => "HMAC-SHA1",
        "SignatureVersion" => "1.0",
        "RegionId" => "ap-southeast-1",
        "AccessKeyId" => access_key_id,
        "Timestamp" => get_timestamp(),
        "SignatureNonce" => UUID.uuid1()
      }
      |> Utils.append_signature(params, access_key_secret)

    post("https://sms-intl.ap-southeast-1.aliyuncs.com", params)
  end

  @doc """
  Aliyun Authenticate Sig Service(人机验证).
  You can read the doc in [Official Link](https://help.aliyun.com/document_detail/66340.html).
  """
  def call_afs(params, access_info \\ nil) do
    access_info = with nil <- access_info, do: get_access_info(:afs)
    access_key_id = Keyword.get(access_info, :access_key_id)
    access_key_secret = Keyword.get(access_info, :access_key_secret)

    params =
      %{
        "Format" => "JSON",
        "Version" => "2018-01-12",
        "SignatureMethod" => "HMAC-SHA1",
        "SignatureVersion" => "1.0",
        "AccessKeyId" => access_key_id,
        "Timestamp" => get_timestamp(),
        "SignatureNonce" => UUID.uuid1()
      }
      |> Utils.append_signature(params, access_key_secret)

    post("https://afs.aliyuncs.com", params)
  end

  @doc """
  Aliyun Project Task Service of CodeUp (云效任务管理).
  You can read the doc in [Official Link](https://help.aliyun.com/document_detail/179127.html).
  """
  def call_codeup(params, access_info \\ nil) do
    access_info = with nil <- access_info, do: get_access_info(:codeup)
    access_key_id = Keyword.get(access_info, :access_key_id)
    access_key_secret = Keyword.get(access_info, :access_key_secret)
    {region, params} = Map.pop(params, "region", "cn-hangzhou")

    params =
      %{
        "Format" => "JSON",
        "Version" => "2020-03-03",
        "SignatureMethod" => "HMAC-SHA1",
        "SignatureVersion" => "1.0",
        "AccessKeyId" => access_key_id,
        "Timestamp" => get_timestamp(),
        "SignatureNonce" => UUID.uuid1()
      }
      |> Utils.append_signature(params, access_key_secret)

    post("https://api-devops.#{region}.aliyuncs.com", params)
  end

  @doc """
  Aliyun Describe Ipv4/6 Location Service(查询IPv4地理位置信息)
  Please note that when using API to query IP Location Information, you need to open the relevant service in the Product package page first.
  You can read the doc in [Official Link](https://help.aliyun.com/document_detail/170546.html?spm=a2c4g.11186623.2.13.4acc1d5cnoHpyi).
  """
  def call_geoip(params, access_info \\ nil) do
    access_info = with nil <- access_info, do: get_access_info(:geoip)
    access_key_id = Keyword.get(access_info, :access_key_id)
    access_key_secret = Keyword.get(access_info, :access_key_secret)

    params =
      %{
        "Format" => "JSON",
        "Version" => "2020-01-01",
        "SignatureMethod" => "HMAC-SHA1",
        "SignatureVersion" => "1.0",
        "AccessKeyId" => access_key_id,
        "Timestamp" => get_timestamp(),
        "SignatureNonce" => UUID.uuid1()
      }
      |> Utils.append_signature(params, access_key_secret)

    post("https://geoip.aliyuncs.com", params)
  end
end
