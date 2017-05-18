defmodule Game.Player do

  alias Game.Cup

  @moduledoc """
  This module holds the state for a player of a game
  """

  use GenServer

  @initial_dice_count 5

  def start_link(id) do
    GenServer.start_link(__MODULE__, id, name: via_tuple(id))
  end

  def via_tuple(id) do
    {:via, Registry, {:table_registry, id}}
  end

  def state(id) do
    GenServer.call(via_tuple(id), :state)
  end

  def dice_count(id) do
    GenServer.call(via_tuple(id), :dice_count)
  end

  def count_for(id, pips) do
    GenServer.call(via_tuple(id), {:count_for, pips})
  end

  def deduct_dice(id) do
    GenServer.call(via_tuple(id), :deduct_dice)
  end

  def get_dice(id), do: GenServer.call(via_tuple(id), :get_dice)

  # def find_or_creeate(id) do
  #   case Registry.lookup(:player_registry, id) do
  #     [] -> Game.Player.start_link(id)
  #   end
  # end

  def init(id) do
    {
      :ok,
      # this is the state
      %{
        id: id,
        name: "Player #{id}",
        number_of_dice: @initial_dice_count,
        cup: Cup.generate(@initial_dice_count)
      }
    }
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  def handle_call(:dice_count, _from, state) do
    {:reply, state.number_of_dice, state}
  end

  def handle_call({:count_for, pips}, _from, state) do
    {:reply, Cup.count_for(pips, state.cup), state}
  end

  def handle_call(:deduct_dice, _from, state) do
    new_state =
      %{ state | number_of_dice: state.number_of_dice - 1}
    {:reply, new_state, new_state}
  end

  def handle_call(:get_dice, _from, state) do
    {:reply, state.cup, state}
  end
end
