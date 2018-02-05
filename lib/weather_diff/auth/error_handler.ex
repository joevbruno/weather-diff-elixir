defmodule WeatherDiff.Auth.ErrorHandler do
  import Plug.Conn
  require Logger

  def auth_error(conn, {type, reason}, opts) do
    Logger.debug("Auth Error: #{inspect(reason)}")
    Logger.debug("Auth Error: #{inspect(type)}")
    Logger.debug("Auth Error: #{inspect(opts)}")
    Logger.debug("Auth Error: #{inspect(conn)}")

    body = Poison.encode!(%{message: to_string(type)})
    send_resp(conn, 401, body)
  end
end
