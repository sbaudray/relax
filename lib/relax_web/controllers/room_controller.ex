defmodule RelaxWeb.RoomController do
  use RelaxWeb, :controller

  alias Relax.Accounts
  alias Relax.Chat
  alias Relax.Chat.Room

  plug :authenticate

  def index(conn, _params) do
    rooms = Chat.list_rooms()
    render(conn, "index.html", rooms: rooms)
  end

  def new(conn, _params) do
    changeset = Room.changeset(%Room{})
    render(conn, "new.html", changeset: changeset)
  end

  def show(conn, params) do
    room = Chat.get_room!(params["room_id"])
    render(conn, "show.html", room: room)
  end

  def create(conn, %{"room" => room_params}) do
    IO.inspect(room_params)

    case Chat.create_room(room_params) do
      {:ok, _room} -> conn |> redirect(to: Routes.room_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} -> render(conn, "new.html", changeset: changeset)
    end
  end

  defp authenticate(conn, _) do
    if user_id = get_session(conn, :user_id) do
      assign(conn, :current_user, Accounts.get_user!(user_id))
    end
  end
end
