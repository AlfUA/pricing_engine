# PricingEngine

- Run `cd pricing_engine` to enter app directory
- Run `mix deps.get` to fetch dependencies
- Run `mix compile` to compile
- Run `iex -S mix` to start shell
- Run `mix test` to run all the tests

## Implementation notes
- Current implementation supports only one type of discount per product
- Current implementation supports only one type of discount (`percent off`) per rule
## Installation

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `pricing_engine` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:pricing_engine, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/pricing_engine>.

