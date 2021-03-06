defmodule WeatherDiffWeb.AuthView do
  use WeatherDiffWeb, :view

  def render("login.json", %{
        jwt: jwt,
        email: email,
        bio: bio,
        username: username,
        image: image,
        first_name: first_name,
        last_name: last_name
      }) do
    %{
      email: email,
      bio: bio,
      username: username,
      image: image,
      first_name: first_name,
      last_name: last_name,
      token: jwt
    }
  end

  def render("signup.json", %{jwt: jwt}) do
    %{token: jwt}
  end

  def render("error.json", %{message: message}) do
    %{message: message}
  end
end
