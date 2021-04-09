defmodule ExMon.PlayerTest do
  use ExUnit.Case

  alias ExMon.Player

  describe "build/1" do
    test "returns struct player" do
      expected_response = %Player{
        life: 100,
        moves: %{
          move_avg: :chute,
          move_heal: :cura,
          move_rnd: :soco
        },
        name: "Jogador1"
      }

      assert expected_response == Player.build("Jogador1", :chute, :soco, :cura)
    end
  end
end
