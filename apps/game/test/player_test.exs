defmodule Game.PlayerTest do

  use ExUnit.Case

  alias Game.Player

  test "can create a player" do
    {:ok, pid} = Player.start_link(1)
    assert is_pid(pid)
  end

  test "cannot start 2 players with the same id" do
    {:ok, pid} = Player.start_link(1)
    assert Player.start_link(1) == {:error, {:already_started, pid}}
  end

  test "can return a player's state" do
    Player.start_link(1)
    assert Player.state(1) ==
      %{
        id: 1,
        name: "Player 1",
        cup: []
      }
  end

  test "can count dice in hand" do
    Player.start_link(1)
    assert Player.dice_count(1) == 0
  end

  # test "has a count of players" do
  #   Game.Player.start_link(1)
  #   assert Game.Player.player_count(1) == 0
  # end

  # test "can add a player" do
  #   Game.Player.start_link(1)
  #   assert Game.Player.player_count(1) == 0
  #   Game.Player.add_player(1, :bill)
  #   assert Game.Player.player_count(1) == 1
  # end
end
