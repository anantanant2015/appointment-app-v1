# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :appointment,
  ecto_repos: [Appointment.Repo]

# Configures the endpoint
config :appointment, Appointment.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZadSIk0mR3GXLaIfYbZ8J10D1vtqQcEZDz6zmNIyFbhkNNwyF2ESd5k3MZFFrO5V",
  render_errors: [view: Appointment.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Appointment.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
