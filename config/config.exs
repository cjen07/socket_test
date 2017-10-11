# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ps,
  ecto_repos: [Ps.Repo]

# Configures the endpoint
config :ps, PsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9BU5OtdSLrb4Vl+cA+LRQlAOd/9oQIdqhMZoG7Rz6dNR7WmioJBggr8BC7MZkfLm",
  render_errors: [view: PsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ps.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
