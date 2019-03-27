defmodule ExAliyunStsTest do
  use ExUnit.Case
  doctest ExAliyunOpenapi

  test "sts: AssumeRole" do
    params = %{
      "Action" => "AssumeRole",
      "RoleArn" => "* Your role arn *",
      "RoleSessionName" => "default",
      "DurationSeconds" => 3600
    }

    assert {:ok, _} = ExAliyunOpenapi.call_sts(params) |> IO.inspect()
  end

  test "sts: GetCallerIdentity" do
    params = %{
      "Action" => "GetCallerIdentity"
    }

    assert {:ok, _} = ExAliyunOpenapi.call_sts(params) |> IO.inspect()
  end
end
