defmodule WeatherDiffWeb.UserController do
  use WeatherDiffWeb, :controller

  alias WeatherDiff.Features.Users
  alias WeatherDiff.Features.User

  action_fallback WeatherDiffWeb.FallbackController

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.json-api", data: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json-api", data: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, "show.json-api", data: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, "show.json-api", data: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end


# defmodule RealWorldWeb.UserController do
#   use RealWorldWeb, :controller
#   use RealWorldWeb.GuardedController

#   alias RealWorld.Accounts.{Auth, Users}

#   action_fallback RealWorldWeb.FallbackController

#   plug Guardian.Plug.EnsureAuthenticated when action in [:current_user, :update]

#   def create(conn, %{"user" => user_params}, _) do
#     case Auth.register(user_params) do
#       {:ok, user} ->
#         {:ok, jwt, _full_claims} = user |> RealWorldWeb.Guardian.encode_and_sign(%{}, token_type: :token)

#         conn
#         |> put_status(:created)
#         |> render("show.json", jwt: jwt, user: user)
#       {:error, changeset} ->
#         render(conn, RealWorldWeb.ChangesetView, "error.json", changeset: changeset)
#     end
#   end

#   def current_user(conn, _params, user) do
#     jwt = RealWorldWeb.Guardian.Plug.current_token(conn)

#     if user != nil do
#       render(conn, "show.json", jwt: jwt, user: user)
#     else
#       conn
#       |> put_status(:not_found)
#       |> render(RealWorldWeb.ErrorView, "404.json", [])
#     end

#     conn
#     |> put_status(:ok)
#     |> render("show.json", jwt: jwt, user: user)
#   end

#   def update(conn, %{"user" => user_params}, user) do
#     jwt = RealWorldWeb.Guardian.Plug.current_token(conn)

#     case Users.update_user(user, user_params) do
#       {:ok, user} ->
#         render(conn, "show.json", jwt: jwt, user: user)
#       {:error, changeset} ->
#         render(conn, RealWorldWeb.ChangesetView, "error.json", changeset: changeset)
#     end
#   end

# end


# defmodule AuthWeb.UserController do
#   use AuthWeb, :controller

#   alias Auth.Account
#   alias Auth.Account.User

#   def index(conn, _params) do
#     users = Account.list_users()
#     render(conn, "index.html", users: users)
#   end

#   def new(conn, _params) do
#     changeset = Account.change_user(%User{})
#     render(conn, "new.html", changeset: changeset)
#   end

#   def create(conn, %{"user" => user_params}) do
#     case Account.create_user(user_params) do
#       {:ok, user} ->
#         conn
#         |> put_flash(:info, "User created successfully.")
#         |> redirect(to: user_path(conn, :show, user))
#       {:error, %Ecto.Changeset{} = changeset} ->
#         render(conn, "new.html", changeset: changeset)
#     end
#   end

#   def show(conn, %{"id" => id}) do
#     user = Account.get_user!(id)
#     render(conn, "show.html", user: user)
#   end

#   def edit(conn, %{"id" => id}) do
#     user = Account.get_user!(id)
#     changeset = Account.change_user(user)
#     render(conn, "edit.html", user: user, changeset: changeset)
#   end

#   def update(conn, %{"id" => id, "user" => user_params}) do
#     user = Account.get_user!(id)

#     case Account.update_user(user, user_params) do
#       {:ok, user} ->
#         conn
#         |> put_flash(:info, "User updated successfully.")
#         |> redirect(to: user_path(conn, :show, user))
#       {:error, %Ecto.Changeset{} = changeset} ->
#         render(conn, "edit.html", user: user, changeset: changeset)
#     end
#   end

#   def delete(conn, %{"id" => id}) do
#     user = Account.get_user!(id)
#     {:ok, _user} = Account.delete_user(user)

#     conn
#     |> put_flash(:info, "User deleted successfully.")
#     |> redirect(to: user_path(conn, :index))
#   end
# end