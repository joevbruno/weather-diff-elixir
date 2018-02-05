defmodule WeatherDiffWeb.Router do
  use WeatherDiffWeb, :router

  pipeline :requests do
    plug(:accepts, ["json", "json-api"])
    # plug :protect_from_forgery
    # plug ProperCase.Plug.SnakeCaseParams
    plug(:put_secure_browser_headers)
  end

  pipeline :json_api do
    plug(JaSerializer.Deserializer)
  end

  pipeline :auth do
    plug(WeatherDiff.Auth.Pipeline)
    plug(WeatherDiff.Plug.SetCurrentUser)
  end

  pipeline :ensure_auth do
    plug(Guardian.Plug.EnsureAuthenticated)
  end

  scope "/auth", WeatherDiffWeb do
    pipe_through([:requests, :json_api])

    post("/login", AuthController, :create)
    post("/signup", AuthController, :sign_up)
  end

  scope "/api", WeatherDiffWeb do
    pipe_through([:requests, :json_api, :auth, :ensure_auth])

    resources("/users", UserController, except: [:new, :edit])
    resources("/locations", LocationController, except: [:new, :edit])
  end
end
