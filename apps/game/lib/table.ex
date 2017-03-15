defmodule Game.Table do

  use GenServer

  def start_link(id) do
    GenServer.start_link(__MODULE__, id, name: via_tuple(id))
  end

  def via_tuple(id) do
    {:via, Registry, {:table_registry, id}}
  end

  def init(id) do
    {
      :ok,
      %{
        name: id,
        players: []
      }
    }
  end
end
