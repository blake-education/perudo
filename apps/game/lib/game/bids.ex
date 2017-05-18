defmodule BidRecord do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [n, p],  %{name: :bids}) # need to init to make
  end

  def init(n, p) do
    default_bid = {0, %{quantity: 0, pips: 1}}
    {
      :ok,
      {
        [default_bid],  # list of bids
        {n, p},         # some way to work out who the next player is - simplify logic here
        default_bid     # last valid bid - what we should compare with
      }
    }
  end

  def handle_call(bid, _from, state) do
    {bids, players, last_bid} = state
    player = elem(bid, 0)
    cond do
      bid =~ {player, :liar}
        -> liar(bid, state)
      not is_next_player?(player, players)
        -> out_of_turn(bid, state)
      bid =~ {player, :timeout}
        -> timeout(bid, state)
      not valid_bid(bid, last_bid)
        -> invalid_bid(bid, state)
      valid_bid(bid, last_bid)
        -> valid_bid(bid, state)
      true
        -> {:error, :bad_message}
    end
  end

  defp liar({p, :liar}, {bids, players, last_bid}) do
    {
      :reply,
      {:end_game},
      {
        [{p, :liar} | bids],
        players,
        last_bid
      },
      :hibernate
    }
  end

  defp out_of_turn({p, _new_bid}, {bids, players, last_bid}) do
    {
      :reply,
      {
        :error,
        :out_of_turn
      },
      {
        bids,
        players,
        last_bid
      },
      :hibernate
    }
  end

  defp function_name do

  end timeout({p, :timeout}, {bids, players, last_bid}) do
    {
      :reply,
      {
        :ok,
        {:timeout, last_bid}
      },
      {
        bids |> List.insert_at(0, {p, :timeout}),
        players |> next_player,
        last_bid
      },
      :hibernate
    }
  end

  defp invalid_bid({_p, new_bid}, {bids, players, last_bid}) do
    {
      :reply,
      {
        :error,
        {:bid_too_low, new_bid, last_bid}
      },
      {
        bids,
        players,
        last_bid
      }
    }
  end

  defp valid_bid({p, new_bid}, {bids, players, _last_bid}) do
    {
      :reply,
      {:ok,
        {:good_bid, new_bid}
      },
      {
        bids |> List.insert_at(0, {p, new_bid}),
        players |> next_player,
        new_bid
      },
      :hibernate
    }
  end

  defp valid_bid?(%{quantity: q1, pips: p1}, %{quantity: q2, pips: p2}) do
    (p1 <= 6) && ((q1 > q2) || ((q1 == q2) && (p1 > p2)))
  end

  def is_next_player?(1, {n, n}), do: true
  def is_next_player?(_, {n, n}), do: false
  def is_next_player?(p + 1, {_, p}), do: true
  def is_next_player?(_, _), do: false

  def next_player({n, n}), do: {n, 1}
  def next_player({n, p}), do: {n, p + 1}
end
