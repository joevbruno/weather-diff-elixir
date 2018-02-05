defmodule WeatherDiffWeb.UserView do
  use WeatherDiffWeb, :view
  use JaSerializer.PhoenixView

  attributes([:first_name, :last_name])
end
