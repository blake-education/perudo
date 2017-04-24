defmodule Game.TableTest do

  use ExUnit.Case

  test "can create a table" do
    {:ok, pid} = Game.Table.start_link(1)
    assert is_pid(pid)
  end

  test "cannot start 2 tables with the same id" do
    {:ok, pid} = Game.Table.start_link(1)
    assert Game.Table.start_link(1) == {:error, {:already_started, pid}}
  end

  test "has a count of players" do
    Game.Table.start_link(1)
    assert Game.Table.player_count(1) == 0
  end

  test "can add a player" do
    Game.Table.start_link(1)
    assert Game.Table.player_count(1) == 0
    Game.Table.add_player(1, :bill)
    assert Game.Table.player_count(1) == 1
  end

  test "gets dice" do
    assert true
  end

  test "gets current bid" do




  end
end
