defmodule Pinger do
  import :timer

  @type host :: String.t()
  @type addr :: String.t()

  @default_timeout seconds(5)

  @spec ping(host, timeout) :: {:ok, addr} | {:error, term}
  def ping(host, timeout) when is_number(timeout), do: do_ping(:inet, host, timeout)

  @spec ping(host) :: {:ok, addr} | {:error, term}
  def ping(host) when is_binary(host), do: do_ping(:inet, host, @default_timeout)

  @spec ping!(host, timeout) :: {:ok, addr}
  def ping!(host, timeout) when is_number(timeout) do
    case ping(host, timeout) do
      {:ok, reply_addr} -> {:ok, reply_addr}
      {:error, reason} -> raise RuntimeError, inspect(reason)
    end
  end

  @spec ping!(host) :: {:ok, addr}
  def ping!(host), do: ping!(host, @default_timeout)

  @spec do_ping(:inet | :inet6, host, timeout) :: {:ok, addr} | {:error, term}
  defp do_ping(type, host, timeout) do
    case :gen_icmp.ping(host |> String.to_charlist(), [type, {:timeout, timeout}]) do
      [{:ok, _host, _address, reply_addr, _details, _payload}] ->
        {:ok, reply_addr |> :inet_parse.ntoa() |> to_string}

      [{:error, icmp_reason, _host, _address, _reply_addr, _details, _payload}] ->
        {:error, icmp_reason}

      [{:error, reason, _host, _address}] ->
        {:error, reason}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
