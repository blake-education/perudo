defmodule Game do

  alias Game.Table

  def join_table do
    Table.find_or_create(1)
  end

  def table_state(id) do
    Table.state(id)
  end
end
