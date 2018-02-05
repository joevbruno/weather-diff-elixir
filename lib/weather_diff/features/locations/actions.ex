defmodule WeatherDiff.Features.Locations do
  import Ecto.Query, warn: false
  alias WeatherDiff.Repo
  alias WeatherDiff.Features.Location

  def list_locations do
    Repo.all(Location)
  end

  def get_location!(id), do: Repo.get!(Location, id)

  def create_location(attrs \\ %{}) do
    %Location{}
    |> Location.changeset(attrs)
    |> Repo.insert()
  end

  def update_location(%Location{} = location, attrs) do
    location
    |> Location.changeset(attrs)
    |> Repo.update()
  end

  def delete_location(%Location{} = location) do
    Repo.delete(location)
  end

  def change_location(%Location{} = location) do
    Location.changeset(location, %{})
  end
end
