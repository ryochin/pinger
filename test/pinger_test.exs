defmodule PingerTest do
  use ExUnit.Case
  doctest Pinger

  test "ping to real domain" do
    assert Pinger.ping("example.com") == {:ok, "93.184.216.34"}
  end

  test "ping to real address" do
    assert Pinger.ping("1.1.1.1") == {:ok, "1.1.1.1"}
  end

  test "ping to non-existent domain" do
    assert Pinger.ping("example.non-existent") == {:error, :nxdomain}
  end

  test "ping to wrong address" do
    assert Pinger.ping("111.222.333.444") == {:error, :nxdomain}
  end

  test "ping to 0.0.0.0" do
    assert Pinger.ping("0.0.0.0", 100) == {:error, :timeout}
  end

  test "ping! to non-existent domain" do
    assert_raise RuntimeError, fn ->
      Pinger.ping!("example.non-existent")
    end
  end
end
