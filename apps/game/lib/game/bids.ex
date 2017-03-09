defmodule BidRecord do
  use GenServer

  # LIAR!!!
  def handle_call({p, :liar}, _from, {bids, bid, n})
    {:reply, {:end_game}, {[{p, :liar} | bids], nil, n}, :hibernate}
    # we need to stop the game and do something different here...
  end

  # not your turn
  def handle_call({p, _new_bid}, _from, {[{q, _old_bid, _status} |bids], n}) when not is_next_player?(p, q, n) do
    {:reply, {:error, :out_of_turn}, {[{q, _old_bid, _status} |bids], n}, :hibernate}
  end

  # next player times out
  def handle_call({p, :timeout}, _from, bids)
    {_p, bid, _status} = hd(bids)
    {:reply, {:ok, {:new_bid, bid}}, {[{p, bid, :timeout} | bids], n}, :hibernate}
  end

  def handle_call({_p, new_bid}, _from, {[{_q, old_bid} |bids], n}) when not is_a_higher_bid?(new_bid, old_bid) do
    {:reply, {:error, {:bid_too_low, old_bid}}, {[{_q, old_bid} |bids], n}, :hibernate}
  end

  def handle_call({p, new_bid}, _from, {[{q, old_bid} |bids], n}) do
    {:reply, {:ok, {:new_bid, new_bid}}, :hibernate}
  end


  def

  start_link(BidRecord, [n, p],  %{name: :bids}) # need to init to make


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

  defp old_bid([{_p, bid, _status} | bids]) do
    bid
  end



end
