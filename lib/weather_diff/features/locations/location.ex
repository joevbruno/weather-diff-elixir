defmodule WeatherDiff.Features.Location do
  use Ecto.Schema
  import Ecto.Changeset
  alias WeatherDiff.Features.Location

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "locations" do
    field(:city, :string)
    field(:cords, :string)
    field(:state, :string)
    belongs_to(:user, WeatherDiff.Features.User)

    timestamps()
  end

  @doc false
  def changeset(%Location{} = location, attrs) do
    location
    |> cast(attrs, [:city, :state, :cords])
    |> validate_required([:city, :state, :cords])
  end
end
