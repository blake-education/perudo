defmodule Game.LiarTest do
  use ExUnit.Case
  alias Game.Liar
  alias Game.Bid

  test "is not valid when bid is more than number of pips" do
    refute Liar.valid?(%Bid{dice_count: 20, face_value: 6}, [1, 2, 3])
  end
end
