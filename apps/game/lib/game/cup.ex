defmodule Cup do
  @moduledoc """
  generat a hand of n dice in a cup
  """

  @spec generate(integer) :: [integer]
  def generate(n) do
    for _ <- 1..n, do: :rand.uniform(6)
  end

  @spec count_for(integer, [integer]) :: integer
  def count_for(pips, dice) do
    Enum.count(dice, fn(p) -> p == 1 or p == pips end)
  end

end
