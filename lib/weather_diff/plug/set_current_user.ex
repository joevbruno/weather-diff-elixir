defmodule WeatherDiff.Plug.SetCurrentUser do
  def init(opts), do: opts

  def call(conn, _opts) do
    user = WeatherDiff.Auth.Guardian.Plug.current_resource(conn)
    Plug.Conn.assign(conn, :current_user, user)
  end
end
