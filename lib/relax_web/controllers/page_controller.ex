defmodule RelaxWeb.PageController do
  use RelaxWeb, :controller

  plug :skip_to_lobby_when_authenticated

  def index(conn, _params) do
    render(conn, "index.html")
  end

  defp skip_to_lobby_when_authenticated(conn, _) do
    case get_session(conn, :user_id) do
      nil -> conn
      _user_id -> conn |> redirect(to: Routes.room_path(conn, :index)) |> halt()
    end
  end
end
