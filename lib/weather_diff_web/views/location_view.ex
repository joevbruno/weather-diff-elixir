defmodule WeatherDiffWeb.LocationView do
  use WeatherDiffWeb, :view
  use JaSerializer.PhoenixView

  attributes [:city, :state, :cords]
end
