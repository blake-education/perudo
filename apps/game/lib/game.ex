defmodule Game do
  alias Game.Table

  def join_table do
    Table.find_or_create(1)
  end

  def table_state(id) do
    Table.state(id)
  end

  def liar?(table_id, caller_id) do
    all_dice = Table.get_dice(table_id)
  end
end
