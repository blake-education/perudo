# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :perudo_web,
  ecto_repos: [PerudoWeb.Repo]

# Configures the endpoint
config :perudo_web, PerudoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4Pi9PZN+jJu5fkF//uEEqwGf5qkdR2aF9srDZy8wko5lJt0SbjAItMpLdCK6nmlv",
  render_errors: [view: PerudoWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PerudoWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
