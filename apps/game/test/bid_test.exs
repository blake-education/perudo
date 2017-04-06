defmodule Game.BidTest do
  use ExUnit.Case
  alias Game.Bid

  test "is not valid with 0 dice" do
    refute Bid.valid?(%Bid{dice_count: 0, face_value: 2}, %Bid{}, 1)
  end

  test "is not valid with too many dice" do
    refute Bid.valid?(%Bid{dice_count: 2, face_value: 2}, %Bid{}, 1)
  end

  test "is not valid with face_value < 2" do
    refute Bid.valid?(%Bid{dice_count: 2, face_value: 1}, %Bid{}, 3)
  end

  test "is not valid with face_value > 6" do
    refute Bid.valid?(%Bid{dice_count: 2, face_value: 7}, %Bid{}, 3)
  end

  test "is not valid with fewer dice" do
    refute Bid.valid?(%Bid{dice_count: 3}, %Bid{dice_count: 4}, 5)
  end

  test "is not valid with lower face_value" do
    refute Bid.valid?(%Bid{face_value: 3}, %Bid{face_value: 4}, 5)
  end

  test "is not valid with same face_value and dice_count" do
    refute Bid.valid?(%Bid{}, %Bid{}, 5)
  end

  test "is valid with increased face_value" do
    assert Bid.valid?(%Bid{face_value: 3}, %Bid{face_value: 2}, 5)
  end

  test "is valid with increased dice_count" do
    assert Bid.valid?(%Bid{dice_count: 3}, %Bid{dice_count: 2}, 5)
  end

  test "is valid with increased dice_count and face_value" do
    assert Bid.valid?(%Bid{dice_count: 3, face_value: 3}, %Bid{dice_count: 2, face_value: 2}, 5)
  end
end
