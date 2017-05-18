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
    assert %{
      id: 1,
      name: "Player 1",
      number_of_dice: 5,
      cup: [_, _, _, _, _],
    } = Player.state(1)
  end

  test "can count dice in hand" do
    Player.start_link(1)
    assert Player.dice_count(1) == 5
  end

  test "can count the number of dice for pips" do
    reply = Player.handle_call({:count_for, 2}, nil, %{cup: [2, 1, 2, 1, 5]})
    assert reply = {:reply, 4, %{cup: [2, 1, 2, 1, 5]}}
  end

  test "can deduct a dice" do
    Player.start_link(1)
    assert Player.dice_count(1) == 5
    Player.deduct_dice(1)
    assert Player.dice_count(1) == 4
  end

  test "returns the dice" do
    reply = Player.handle_call(:get_dice, nil, %{cup: [2, 1, 2, 1, 5]})
    assert reply = {:reply, [2, 1, 2, 1, 5], %{cup: [2, 1, 2, 1, 5]}}
  end
end
