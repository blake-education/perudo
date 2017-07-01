defmodule Game do
  alias Game.{Table, TableSupervisor}

  def join_table do
    if Registry.lookup(:table_registry, 1) == [] do
      TableSupervisor.create_table(1)
    end
    1
  end

  def table_state(id) do
    Table.state(id)
  end

  def liar?(table_id, caller_id) do
    all_dice = Table.get_dice(table_id)
  end
end
