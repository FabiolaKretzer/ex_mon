# ExMon

Criar jogador
```elixir
player = ExMon.create_pĺayer("Jogador1", :chute, :soco, :cura)
```

Iniciar jogo
```elixir
ExMon.start_game(player)
```

Movimento do jogador
```elixir
ExMon.make_move(:chute)
```

Pegar estado do jogo
```elixir
ExMon.Game.info()
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_mon` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_mon, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ex_mon](https://hexdocs.pm/ex_mon).

