# The other pipeline will leverage this one, and be defiend in our router. 
# This pipeline checks for a resource (a user) but does not reject the request if one is not found
defmodule WeatherDiff.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :weather_diff,
    error_handler: WeatherDiff.Auth.ErrorHandler,
    module: WeatherDiff.Auth.Guardian

  # If there is a session token, validate it
  plug(Guardian.Plug.VerifySession)
  # If there is an authorization header, validate it
  # , claims: %{"typ" => "access"} #realm: "Token"
  plug(Guardian.Plug.VerifyHeader)
  # Load the user if either of the verifications worked
  plug(Guardian.Plug.LoadResource, allow_blank: true)
end
