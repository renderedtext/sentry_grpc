defmodule Sentry.GrpcTest do
  use ExUnit.Case
  doctest Sentry.Grpc

  test "greets the world" do
    assert Sentry.Grpc.hello() == :world
  end
end
