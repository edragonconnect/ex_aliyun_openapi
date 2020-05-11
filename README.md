# ExAliyunOpenapi

## Description
ExAliyunOpenapi supports aliyun openapis:
* CPS(移动推送服务)
* STS(短期访问权限管理)
* SMS(短信服务)
* more to be supported

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_aliyun_openapi` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_aliyun_openapi, "~> 0.3.0"}
  ]
end
```

## Configuration
You should add configs for your services in this way.
```elixir
config :ex_aliyun_openapi, :cps,
  access_key_id: "YOUR CPS ACCESS KEY ID",
  access_key_secret: "YOUR CPS ACCESS KEY SECRET"

config :ex_aliyun_openapi, :sts,
  access_key_id: "YOUR STS ACCESS KEY ID",
  access_key_secret: "YOUR STS ACCESS KEY SECRET"

config :ex_aliyun_openapi, :sms,
  access_key_id: "YOUR SMS ACCESS KEY ID",
  access_key_secret: "YOUR SMS ACCESS KEY SECRET"

config :ex_aliyun_openapi, :global_sms,
  access_key_id: "YOUR SMS ACCESS KEY ID",
  access_key_secret: "YOUR SMS ACCESS KEY SECRET"
```

## Call the apis 
You can find the api params in [https://help.aliyun.com](https://help.aliyun.com).
Then you can choose the service, and just put the params to it.
```elixir
params = %{
  "Action" => "AssumeRole",
  "RoleArn" => "**YOUR RoleArn**",
  "RoleSessionName" => "default",
  "DurationSeconds" => 3600,
}
ExAliyunOpenapi.call_sts(params)
```
```elixir
params = %{
  "Action" => "PushNoticeToAndroid",
  "AppKey" => "**YOUR AppKey**",
  "Target" => "DEVICE",
  "TargetValue" => "**YOUR device_id**",
  "Title" => "TEST title",
  "Body" => "Hello, this is the notice body"
}
assert {:ok, _} = ExAliyunOpenapi.call_cps(params)
```

```elixir
params = %{
  "To" => "Your Phone Num",
  "From" => "Your SignName",
  "TemplateCode" => "Your TemplateCode",
  "TemplateParam" => "Your Json Params",
  "Action" => "SendMessageWithTemplate"
}
assert {:ok, _} = ExAliyunOpenapi.call_global_sms(params)
```

## To add more services to this repo
You should add the service client to `http.ex`.
Then add the common params and url to `middleware.ex`.
