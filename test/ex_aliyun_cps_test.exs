defmodule ExAliyunCpsiTest do
  use ExUnit.Case
  doctest ExAliyun.OpenAPI

  test "cps: ListSummaryApps" do
    assert {:ok, _} = ExAliyun.OpenAPI.call_cps(%{"Action" => "ListSummaryApps"})
  end

  test "cps: ListTags" do
    assert {:ok, _} =
             ExAliyun.OpenAPI.call_cps(%{"Action" => "ListTags", "AppKey" => "* Your app key *"})
  end

  test "cps: Push -- superior -- ios" do
    push_time = "2018-07-20T09:33:39Z"
    # target_value = %{and: [%{tag: "trevor"}, %{tag: "en"}]} |> Jason.encode!
    target_value = %{tag: "trevor"} |> Jason.encode!()

    params = %{
      # "PushTime" => push_time,
      "Action" => "Push",
      "AppKey" => 999_999_999_999,
      "Target" => "TAG",
      "TargetValue" => target_value,
      "DeviceType" => "iOS",
      "PushType" => "NOTICE",
      "Title" => "Test PUSH full api",
      "Body" => "Hello, it is a test",
      "iOSApnsEnv" => "DEV",
      # "iOSBadgeAutoIncrement" => "True",
      "iOSSubtitle" => "It is a subtitle"
    }

    assert {:ok, _} = ExAliyun.OpenAPI.call_cps(params)
  end
end
