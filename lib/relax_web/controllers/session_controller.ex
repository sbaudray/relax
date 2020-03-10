defmodule RelaxWeb.SessionController do
  use RelaxWeb, :controller

  alias Relax.Accounts
  alias Accounts.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => %{"name" => username}}) do
    case Accounts.authenticate_by_name(username) do
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
