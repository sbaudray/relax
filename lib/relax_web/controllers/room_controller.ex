defmodule RelaxWeb.RoomController do
  use RelaxWeb, :controller
  alias Relax.Chat
  alias Relax.Chat.Room

  def index(conn, _params) do
    rooms = Chat.list_rooms()
    render(conn, "index.html", rooms: rooms)
  end

  def new(conn, _params) do
    changeset = Room.changeset(%Room{})
    render(conn, "new.html", changeset: changeset)
  end

  def show(conn, params) do
    messages = Chat.list_messages_by_room(params["room_id"])
    render(conn, "show.html", messages: messages)
  end

  def create(conn, %{"room" => room_params}) do
    case Chat.create_room(room_params) do
      {:ok, _room} -> conn |> redirect(to: Routes.room_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} -> render(conn, "new.html", changeset: changeset)
    end
  end
end
