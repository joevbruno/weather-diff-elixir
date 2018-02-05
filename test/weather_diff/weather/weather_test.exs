defmodule WeatherDiff.WeatherTest do
  use WeatherDiff.DataCase

  alias WeatherDiff.Weather

  describe "users" do
    alias WeatherDiff.Weather.User

    @valid_attrs %{first_name: "some first_name", last_name: "some last_name"}
    @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name"}
    @invalid_attrs %{first_name: nil, last_name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Weather.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Weather.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Weather.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Weather.create_user(@valid_attrs)
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Weather.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Weather.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Weather.update_user(user, @invalid_attrs)
      assert user == Weather.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Weather.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Weather.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Weather.change_user(user)
    end
  end

  describe "locations" do
    alias WeatherDiff.Weather.Location

    @valid_attrs %{city: "some city", cords: "some cords", state: "some state"}
    @update_attrs %{
      city: "some updated city",
      cords: "some updated cords",
      state: "some updated state"
    }
    @invalid_attrs %{city: nil, cords: nil, state: nil}

    def location_fixture(attrs \\ %{}) do
      {:ok, location} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Weather.create_location()

      location
    end

    test "list_locations/0 returns all locations" do
      location = location_fixture()
      assert Weather.list_locations() == [location]
    end

    test "get_location!/1 returns the location with given id" do
      location = location_fixture()
      assert Weather.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location" do
      assert {:ok, %Location{} = location} = Weather.create_location(@valid_attrs)
      assert location.city == "some city"
      assert location.cords == "some cords"
      assert location.state == "some state"
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Weather.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      location = location_fixture()
      assert {:ok, location} = Weather.update_location(location, @update_attrs)
      assert %Location{} = location
      assert location.city == "some updated city"
      assert location.cords == "some updated cords"
      assert location.state == "some updated state"
    end

    test "update_location/2 with invalid data returns error changeset" do
      location = location_fixture()
      assert {:error, %Ecto.Changeset{}} = Weather.update_location(location, @invalid_attrs)
      assert location == Weather.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      location = location_fixture()
      assert {:ok, %Location{}} = Weather.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Weather.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      location = location_fixture()
      assert %Ecto.Changeset{} = Weather.change_location(location)
    end
  end
end
