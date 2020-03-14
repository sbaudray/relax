defmodule RelaxWeb.RoomController do
  use RelaxWeb, :controller
  alias Relax.Chat
  alias Relax.Chat.Room

  plug :authorize_owner when action in [:delete]

  def index(conn, _params) do
    rooms = Chat.list_rooms()
    render(conn, "index.html", rooms: rooms)
  end

  def new(conn, _params) do
    changeset = Room.changeset(%Room{})
    render(conn, "new.html", changeset: changeset)
  end

  def show(conn, %{"id" => room_id}) do
    messages = Chat.list_messages_by_room(room_id)
    room = Chat.get_room!(room_id)
    render(conn, "show.html", messages: messages, room: room)
  end

  def create(conn, %{"room" => room_params}) do
    payload = Map.put(room_params, "user_id", conn.assigns.current_user.id)

    case Chat.create_room(payload) do
      {:ok, _room} -> conn |> redirect(to: Routes.room_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} -> render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => room_id}) do
    room = Chat.get_room!(room_id)

    with {:ok, %Room{}} <- Chat.delete_room(room) do
      conn |> redirect(to: Routes.room_path(conn, :index))
    end
  end

  defp authorize_owner(conn, _) do
    room = Chat.get_room!(conn.params["id"])

    if conn.assigns.current_user.id == room.user_id do
      conn
    else
      conn
      |> put_flash(:error, "You must own this room to do that")
      |> redirect(to: Routes.room_path(conn, :index))
      |> halt()
    end
  end
end
