defmodule Game.Player do

  @moduledoc """
  This module holds the state for a player of a game
  """

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

  def dice_count(id) do
    GenServer.call(via_tuple(id), :dice_count)
  end

  # def find_or_creeate(id) do
  #   case Registry.lookup(:player_registry, id) do
  #     [] -> Game.Player.start_link(id)
  #   end
  # end

  def init(id) do
    {
      :ok,
      %{
        id: id,
        name: "Player #{id}",
        cup: []
      }
    }
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  def handle_call(:dice_count, _from, state) do
    {:reply, length(state.cup), state}
  end
end
