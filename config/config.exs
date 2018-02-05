# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :weather_diff,
  ecto_repos: [WeatherDiff.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :weather_diff, WeatherDiffWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EG9Q7KR68+MIY9bw+6jspgwslrkdz090gqy8etzbH77iry9UIauq/dRTgqGBRRIx",
  render_errors: [view: WeatherDiffWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: WeatherDiff.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :mime, :types, %{
  "application/vnd.api+json" => ["json-api"]
}

# n a production environment the secret_key is a secret and should not be hard-coded into your configuration file or checked into Github; you should replace it with an environment variable
config :weather_diff, WeatherDiff.Auth.Guardian,
  issuer: "weather_diff",
  secret_key: "tePgNdOFYFF0gWcnl4M0IyE3KL74dkGZBd4+s0ZA465S+qIwHMKjstSTWoewob1L"
      #  token_module: Guardian.Token.Jwt

config :weather_diff, WeatherDiff.Auth.Pipeline,
  module: WeatherDiff.Auth.Guardian,
  error_handler: WeatherDiff.Auth.ErrorHandler

config :phoenix, :format_encoders,
  "json-api": Poison

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
