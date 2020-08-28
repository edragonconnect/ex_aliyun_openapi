# ExAliyun.OpenAPI

## Description
ExAliyun.OpenAPI supports aliyun openapis:
* CPS(移动推送服务)
* STS(短期访问权限管理)
* SMS(短信服务)
* AFS(人机验证)
* CodeUp(云效任务管理)
* more to be supported

## Installation

If [available in Hex](https://hex.pm/packages/ex_aliyun_openapi), the package can be installed
by adding `ex_aliyun_openapi` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_aliyun_openapi, "~> 0.6.0"}
  ]
end
```

## Configuration
You should add configs for your services in this way.
```elixir
config :ex_aliyun_openapi, type,
  access_key_id: "YOUR CPS ACCESS KEY ID",
  access_key_secret: "YOUR CPS ACCESS KEY SECRET"
```
type support `[:cps, :sts, :sms, :global_sms, :afs, :codeup]`

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
ExAliyun.OpenAPI.call_sts(params)

# or

ExAliyun.OpenAPI.call_sts(params, access_key_id: "ID", access_key_secret: "SECRET")
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
ExAliyun.OpenAPI.call_cps(params)

# or

ExAliyun.OpenAPI.call_cps(params, access_key_id: "ID", access_key_secret: "SECRET")
```

## To add more services to this repo
You should add the service client to `http.ex`.
Then add the common params and url to `middleware.ex`.
