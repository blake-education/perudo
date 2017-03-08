defmodule Cup do
  @moduledoc """
  generat a hand of n dice in a cup
  """

  @spec new(integer) :: [integer]
  def new(n) do
    for _ <- 1..n, do: :rand.uniform(6)
  end
end
