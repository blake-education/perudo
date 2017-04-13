defmodule Game.Liar do

  alias Game.Bid
  alias Game.Player

  @spec valid?(%Bid{}, [integer]) :: boolean
  def valid?(bid, player_ids) do
    count_by_bid_face_value(bid.face_value, player_ids) >= bid.dice_count
  end

  defp count_by_bid_face_value(face_value, player_ids) do
    player_ids
    |> Enum.reduce(fn(player_id, acc) ->
      acc + Player.count_for(player_id, face_value)
    end)
  end
end
