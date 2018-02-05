defmodule WeatherDiff.Auth.Encryption do
  @moduledoc """
  Encrpytion with comeonin and Argon2
  """
  alias Comeonin.Argon2

  def hash_password(password), do: Argon2.hashpwsalt(password)
  def validate_password(password, hash), do: Argon2.checkpw(password, hash)
end
