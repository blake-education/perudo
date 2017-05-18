defmodule Game.Table do

  use GenServer

  def start_link(id) do
    GenServer.start_link(__MODULE__, id, name: via_tuple(id))
  end

  def via_tuple(id) do
    {:via, Registry, {:table_registry, id}}
  end

  def state(id) do
    GenServer.call(via_tuple(id), :state)
  end

  def player_count(id) do
    GenServer.call(via_tuple(id), :player_count)
  end

  def add_player(id, player_id) do
    GenServer.call(via_tuple(id), {:add_player, id})
  end

  def get_dice(id) do
    GenServer.call(via_tuple(id), :get_dice)
  end

  def get_current_bid(id) do
    GenServer.call(via_tuple(id), :get_current_bid)
  end
  
  def find_or_create(id) do
    IO.inspect Registry.lookup(:table_registry, id)
    if Registry.lookup(:table_registry, id) == [] do
      Game.Table.start_link(id)
    end
    id
  end

  def init(id) do
    {
      :ok,
      %{
        name: id,
        players: [],
        current_bid: %Game.Bid{}
      }
    }
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  def handle_call(:player_count, _from, state) do
    {:reply, length(state.players), state}
  end

  def handle_call({:add_player, player_id}, _from, state) do
    new_state = %{
      state | players: [player_id] ++ state.players
    }
    {:reply, new_state.players, new_state}
  end

  def handle_call(:get_dice, _from, state) do
    all_dice =
      state.players
      |> Enum.flat_map(fn(player) ->
        Game.Player.get_dice(player)
      end)
    {:reply, all_dice, state}
  end

  def handle_call(:get_current_bid, _from, state) do
    {:reply, state.current_bid, state}
  end
end
