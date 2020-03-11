defmodule Relax.Chat do
  import Ecto.Query
  alias Relax.Repo

  alias Relax.Chat.{Room, Message}

  def list_rooms do
    Room |> Repo.all()
  end

  def get_room!(id) do
    Room |> Repo.get!(id)
  end

  def create_room(attrs) do
    %Room{} |> Room.changeset(attrs) |> Repo.insert()
  end

  def create_message(attrs) do
    %Message{} |> Message.changeset(attrs) |> Repo.insert()
  end

  def list_messages_by_room(room_id) do
    query = from m in Message, where: m.room_id == ^room_id

    Repo.all(query)
  end
end
