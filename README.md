# Pinger

> Simple ICMP Ping library for Elixir

**CAUTION** This software is under early alpha stage. Any APIs could be changed in the future.

## Installation

To install `Pinger`, add it to your `mix.exs` file:

```elixir
def deps do
  [
    {:pinger, github: "ryochin/pinger"}
  ]
end
```

Then, run `$ mix deps.get`.

Usage
-----

Do ICMP ping to the `host`. The default `timeout` is 5,000 ms.

```elixir
iex> Pinger.ping("1.1.1.1")
{:ok, "1.1.1.1"}

iex> import :timer
iex> Pinger.ping("8.8.8.8", seconds(2))
{:ok, "8.8.8.8"}

iex> Pinger.ping("example.com")
{:ok, "93.184.216.34"}

iex> Pinger.ping("192.168.255.255")
{:error, :timeout}

iex> Pinger.ping("example.non-existent")
{:error, :nxdomain}

iex> Pinger.ping!("example.non-existent")
** (RuntimeError) :nxdomain
    (pinger) lib/pinger.ex:19: Pinger.ping!/2
```

Caveats
-------

IPv4 only (but `gen_icmp` itself supports IPv6)

See Also
--------

* [gen_icmp](https://github.com/msantos/gen_icmp)