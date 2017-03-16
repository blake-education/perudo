defmodule BidRecord do
  use GenServer

  def start_link
    GenServer.start_link(__MODULE__, [n, p],  %{name: :bids}) # need to init to make
  end

  def init(n, p) do
    default_bid = {0, %{quantity:0, pips:1}}
    {
      :ok,
      {
        [default_bid],  # list of bids
        {n, p},         # some way to work out who the next player is - simplify logic here
        default_bid     # last valid bid - what we should compare with
      }
    }
  end

  # LIAR!!!
  def handle_call({p, :liar}, _from, {bids, players, last_bid})
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

  # not your turn
  def handle_call({p, _new_bid}, _from, {bids, players, last_bid}) when not is_next_player?(p, players) do
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

  # next player times out
  def handle_call({p, :timeout}, _from, {bids, players, last_bid})
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

  # bid too low
  def handle_call({_p, new_bid}, _from, {bids, players, last_bid}) when not is_a_higher_bid?(new_bid, last_bid) do
    {
      :reply,
      {
        :error,
        {:bid_too_low, last_bid}
      },
      {
        bids,
        players,
        last_bid
      }
    }
  end

  # valid bid form valid player.
  def handle_call({p, new_bid}, _from, {bids, players, last_bid}) do
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

  # defp is_next_player(new_player, old_player, number_of_players)
  defmacro is_next_player?(q, p, n), do: true
    quote do
      (unquote(q) == unquote(p) + 1) || ((unquote(p) == unquote(n)) && (unquote(q) == 1))
    end
  end

  #defp is_a_higher_bid(old_bid, new_bid)
  defmacro is_a_higher_bid?(%{quantity: q1, pips: p1}, %{quantity: q2, pips: p2}) do
    quote do
      (unquote(q1) > unquote(q2)) || ((unquote(q1) == unquote(q2)) && (unquote(p1) > unquote(p2)))
    end
  end

  def next_player({n, n}), do: {n, 1}
  def next_player({n, p}), do: {n, p+1}
end
