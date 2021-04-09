defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = ExMon.create_pĺayer("Jogador1", :chute, :soco, :cura)
      computer = ExMon.create_pĺayer("Robotinik", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player, :computer)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = ExMon.create_pĺayer("Jogador1", :chute, :soco, :cura)
      computer = ExMon.create_pĺayer("Robotinik", :chute, :soco, :cura)

      Game.start(computer, player, :computer)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{
            move_avg: :chute,
            move_heal: :cura,
            move_rnd: :soco
            },
          name: "Robotinik"
        },
        player: %Player{
          life: 100,
          moves: %{
            move_avg: :chute,
            move_heal: :cura,
            move_rnd: :soco
          },
          name: "Jogador1"
        },
        status: :started,
        turn: :computer
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "returns the game sate updated" do
      player = ExMon.create_pĺayer("Jogador1", :chute, :soco, :cura)
      computer = ExMon.create_pĺayer("Robotinik", :chute, :soco, :cura)

      Game.start(computer, player, :player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{
            move_avg: :chute,
            move_heal: :cura,
            move_rnd: :soco
            },
          name: "Robotinik"
        },
        player: %Player{
          life: 100,
          moves: %{
            move_avg: :chute,
            move_heal: :cura,
            move_rnd: :soco
          },
          name: "Jogador1"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()

      new_state = %{
        computer: %Player{
          life: 50,
          moves: %{
            move_avg: :chute,
            move_heal: :cura,
            move_rnd: :soco
            },
          name: "Robotinik"
        },
        player: %Player{
          life: 20,
          moves: %{
            move_avg: :chute,
            move_heal: :cura,
            move_rnd: :soco
          },
          name: "Jogador1"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | status: :continue, turn: :computer}

      assert expected_response == Game.info()
    end
  end
end
