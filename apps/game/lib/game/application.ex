defmodule Game.Application do
  use Application

  @moduledoc """
  the Game application holds game logic for Perudo
  """

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: Dossier.Worker.start_link(arg1, arg2, arg3)
      supervisor(Registry, [:unique, :table_registry]),
      supervisor(Registry, [:unique, :player_registry], id: make_ref())
      # worker(Game.Worker, [arg1, arg2, arg3]),
      # supervisor(Game.Repo, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Game.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
