defmodule Game.Bid do

  defstruct dice_count: 0, face_value: 2
  alias Game.Bid

  @spec valid?(%Bid{}, %Bid{}, integer) :: boolean
  def valid?(new_bid, current_bid, dice_count) do
    has_valid_face_value?(new_bid) &&
    has_valid_dice_count?(new_bid, dice_count) &&
    new_bid_is_higher?(new_bid, current_bid)
  end

  defp has_valid_dice_count?(new_bid, dice_count) do
    has_at_least_one_di?(new_bid) &&
    has_at_most_dice_count_di?(new_bid, dice_count)
  end

  defp has_valid_face_value?(new_bid) do
    new_bid.face_value > 1 && new_bid.face_value < 7
  end

  defp has_at_least_one_di?(bid) do
    bid.dice_count > 0
  end

  defp has_at_most_dice_count_di?(bid, dice_count) do
    bid.dice_count <= dice_count
  end

  defp new_bid_is_higher?(new_bid, current_bid) do
    dice_count_is_higher?(new_bid, current_bid) || face_value_is_higher?(new_bid, current_bid)
  end

  defp dice_count_is_higher?(new_bid, current_bid) do
    new_bid.dice_count > current_bid.dice_count
  end

  defp face_value_is_higher?(new_bid, current_bid) do
    new_bid.face_value > current_bid.face_value &&
    new_bid.dice_count >= current_bid.dice_count
  end
end
