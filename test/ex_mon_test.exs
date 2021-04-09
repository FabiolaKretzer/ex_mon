defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.{Game, Player}

  describe "create_player/4" do
    test "returns a player" do
      expected_response =
        %Player{
          life: 100,
          moves: %{
            move_avg: :chute,
            move_heal: :cura,
            move_rnd: :soco
          },
          name: "Jogador1"
        }

      assert expected_response == ExMon.create_pĺayer("Jogador1", :chute, :soco, :cura)
    end
  end

  describe "start_game/4" do
    test "when the game is started, returns a message" do
      player = ExMon.create_pĺayer("Jogador1", :chute, :soco, :cura)

      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

      assert messages =~ "The game is started!"
      assert messages =~ "status: :started"
    end
  end

  describe "make_move/1" do
    setup do
      player = ExMon.create_pĺayer("Jogador1", :chute, :soco, :cura)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when the move is valid, do the move and the computer makes a move" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:chute)
        end)

      assert messages =~ "The Player attacked the computer dealing"
      assert messages =~ "It's computer turn!"
      assert messages =~ "It's player turn!"
      assert messages =~ "status: :continue"
    end

    test "when the move is invalid, returns an error message" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:wrong)
        end)

      assert messages =~ "Invalid move: wrong"
    end

    test "when the move with game over, returns game over message" do
      state = Game.info()
      player = %{state.player | life: 0}
      new_state = %{state | player: player, status: :game_over}

      Game.update(new_state)

      messages =
        capture_io(fn ->
          ExMon.make_move(:chute)
        end)

      assert messages =~ "The game is over!"
      assert messages =~ "status: :game_over"
    end
  end
end
