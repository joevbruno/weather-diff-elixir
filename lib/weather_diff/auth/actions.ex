defmodule WeatherDiff.Auth.Actions do
  import Ecto.{Query, Changeset}, warn: false

  alias WeatherDiff.Auth.Encryption
  alias WeatherDiff.Features.User
  alias WeatherDiff.Repo

  def login(params) do
    user = Repo.get_by(User, email: String.downcase(params["email"]))
      case authenticate(user, params["password"]) do
      true -> {:ok, user}
      _    -> :error
    end
  end

  defp authenticate(user, password) do
    case user do
    nil -> false
    _   -> Encryption.validate_password(password, user.password_hash)
    end
  end

  def register(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert
  end
end
