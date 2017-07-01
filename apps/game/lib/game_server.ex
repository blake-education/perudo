defmodule Game.TableSupervisor do

  alias Game.Table
  use Supervisor

  def create_table(id) do
    Supervisor.start_child(__MODULE__, [id])
  end

  ###
  # Supervisor API
  ###

  def start_link do
    Supervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    children = [
      worker(Table, [], restart: :transient)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end


end
