# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :pricefinder, PricefinderWeb.Endpoint,
  url: [host: "localhost"],
  http: [port: 4000],
  secret_key_base: "i+alUyujf0y4RQ6A7kPCkmUnGe2esNzZ62Jlpge5Ld/5YvU1aZLke53cmIS5kRml",
  render_errors: [view: PricefinderWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Pricefinder.PubSub,
  live_view: [signing_salt: "/+912qAs"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
