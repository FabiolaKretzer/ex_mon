defmodule ExMon do
  alias ExMon.{Game, Player}
  alias ExMon.Game.{Actions, Status}

  @computer_name "Robotinik"
  @computer_moves [:move_avg, :move_rnd, :move_heal]
  @players [:player, :player]

  def create_pĺayer(name, move_avg, move_rnd, move_heal) do
    Player.build(name, move_avg, move_rnd, move_heal)
  end

  def start_game(player) do
    first_player = Enum.random(@players)

    @computer_name
    |> create_pĺayer(:punch, :kick, :heal)
    |> Game.start(player, first_player)

    current = Game.info()

    Status.print_round_message(current)

    is_computer(current)
  end

  def make_move(move) do
    Game.info()
    |> Map.get(:status)
    |> handle_status(move)
  end

  defp is_computer(%{turn: :computer} = computer) do
    computer
    |> computer_move()
  end

  defp is_computer(%{turn: :player}), do: :ok

  defp handle_status(:game_over, _move), do: Status.print_round_message(Game.info())

  defp handle_status(_other, move) do
    move
    |> Actions.fetch_move()
    |> do_move()

    computer_move(Game.info())
  end

  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)

  defp do_move({:ok, move}) do
    case move do
      :move_heal -> Actions.heal()
      move -> Actions.attack(move)
    end

    Status.print_round_message(Game.info())
  end

  defp computer_move(%{computer: computer, turn: :computer} = info)
    when info.status == :started or info.status == :continue do

    computer.life
    |> random_computer_move()
  end

  defp computer_move(_), do: :ok

  defp random_computer_move(life) when life < 40 do
    {:ok, Enum.random(@computer_moves ++ [:move_heal])}
    |> do_move()
  end

  defp random_computer_move(_) do
    {:ok, Enum.random(@computer_moves)}
    |> do_move()
  end
end
