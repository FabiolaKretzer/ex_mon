defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  @player ExMon.create_pĺayer("Jogador1", :chute, :soco, :cura)
  @computer ExMon.create_pĺayer("Robotinik", :chute, :soco, :cura)
  @life 50
  @start_game_computer %{
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

  @start_game_player %{@start_game_computer | turn: :player}

  describe "start/2" do
    test "starts the game state" do
      assert {:ok, _pid} = Game.start(@computer, @player, :computer)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      Game.start(@computer, @player, :computer)

      expected_response = @start_game_computer

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      Game.start(@computer, @player, :player)

      expected_response = @start_game_player

      assert expected_response == Game.info()

      player = %{@start_game_player.player | life: @life}
      computer = %{@start_game_player.computer | life: @life}

      new_state = %{@start_game_player | player: player, computer: computer}

      Game.update(new_state)

      expected_response = %{new_state | status: :continue, turn: :computer}

      assert expected_response == Game.info()
    end
  end

  describe "player/0" do
    test "returns the player of the game" do
      Game.start(@computer, @player, :player)

      expected_response = @start_game_player.player

      assert expected_response == Game.player()
    end
  end

  describe "turn/0" do
    test "returns the turn of the game" do
      Game.start(@computer, @player, :player)

      expected_response = :player

      assert expected_response == Game.turn()

      new_state = @start_game_player

      Game.update(new_state)

      expected_response = :computer

      assert expected_response == Game.turn()
    end
  end

  describe "fetch_player/1" do
    test "returns the player of the game" do
      Game.start(@computer, @player, :computer)

      expected_response = @start_game_player.computer

      assert expected_response == Game.fetch_player(:computer)
    end
  end
end
