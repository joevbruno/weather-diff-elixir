defmodule WeatherDiffWeb.AuthController do
  use WeatherDiffWeb, :controller
  require Logger

  alias WeatherDiff.Auth.Actions

  action_fallback(WeatherDiffWeb.FallbackController)

  def create(conn, params) do
    case Actions.login(params) do
      {:ok, user} ->
        {:ok, jwt, _full_claims} =
          user |> WeatherDiff.Auth.Guardian.encode_and_sign(%{}, token_type: :token)

        %{
          email: email,
          bio: bio,
          username: username,
          image: image,
          first_name: first_name,
          last_name: last_name
        } = user

        conn
        |> put_status(:created)
        |> render(
          WeatherDiffWeb.AuthView,
          "login.json",
          jwt: jwt,
          email: email,
          bio: bio,
          username: username,
          image: image,
          first_name: first_name,
          last_name: last_name
        )

      {:error, message} ->
        conn
        |> put_status(401)
        |> render(WeatherDiffWeb.AuthView, "error.json", message: message)
    end
  end

  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> put_status(:forbidden)
    |> render(WeatherDiffWeb.AuthView, "error.json", message: "Not Authenticated")
  end

  def sign_up(conn, %{"user" => user_params}) do
    case Actions.register(user_params) do
      {:ok, user} ->
        {:ok, jwt, _full_claims} =
          user |> WeatherDiff.Auth.Guardian.encode_and_sign(%{}, token_type: :token)

        Logger.debug("Var value: #{inspect(jwt)}")
        Logger.debug("Var value: #{inspect(user)}")

        conn
        |> put_status(:created)
        |> render(WeatherDiffWeb.AuthView, "signup.json", jwt: jwt)

      {:error, changeset} ->
        render(conn, WeatherDiffWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
