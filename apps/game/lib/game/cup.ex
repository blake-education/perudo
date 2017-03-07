defmodule Cup do
  @moduledoc """
  generat a hand of n dice in a cup
  """

  @spec new(integer) :: [integer]
  def new(n, acc \\ [])
  def new(0, acc), do: acc
  def new(n, acc) do
    new(n-1, [:rand.uniform(6) | acc])
  end
end
