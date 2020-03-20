defmodule RelaxWeb.SessionController do
  use RelaxWeb, :controller

  alias Relax.Accounts

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session_params" => %{"name" => username, "password" => password}}) do
    case Accounts.authenticate_by_username_and_password(username, password) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome #{user.name}")
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
        |> redirect(to: Routes.room_path(conn, :index))

      {:error, _} ->
        conn
        |> put_flash(:error, "Wrong credentials")
        |> redirect(to: Routes.session_path(conn, :new))
    end
  end

  def delete(conn, _) do
    conn |> configure_session(drop: true) |> redirect(to: Routes.page_path(conn, :index))
  end
end
