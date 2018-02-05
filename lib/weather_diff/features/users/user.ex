defmodule WeatherDiff.Features.User do
  @moduledoc """
  User
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias WeatherDiff.Features.User
  alias WeatherDiff.Auth.Encryption

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    field(:email, :string, unique: true)
    field(:username, :string, unique: true)

    field(:password_hash, :string)
    field(:password, :string, virtual: true)
    field(:password_confirmation, :string, virtual: true)

    field(:first_name, :string)
    field(:last_name, :string)

    field(:bio, :string)
    field(:image, :string)

    field(:login_attempts, :int, default: 0)
    field(:status, :string, default: "active")
    field(:processing, :boolean, default: false)

    timestamps()
  end

  # @required_fields ~w(:email :username :password)
  # @optional_fields ~w(:bio :image :first_name :last_name)

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :username, :password, :bio, :image, :first_name, :last_name])
    |> validate_required([:email, :username, :password])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/.+@.+\..+/, message: "Please input a valid email")
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password)
    |> downcase_email
    |> downcase_username
    |> encrypt_password
  end

  defp encrypt_password(changeset) do
    password = get_change(changeset, :password)

    if password do
      encrypted_password = Encryption.hash_password(password)
      put_change(changeset, :password_hash, encrypted_password)
    else
      changeset
    end
  end

  defp downcase_email(changeset) do
    update_change(changeset, :email, &String.downcase/1)
  end

  defp downcase_username(changeset) do
    update_change(changeset, :username, &String.downcase/1)
  end
end
