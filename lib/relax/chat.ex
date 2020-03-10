defmodule Relax.Chat do
  # import Ecto.Query
  alias Relax.Repo

  alias Relax.Chat.Room

  def list_rooms do
    Room |> Repo.all()
  end

  def get_room!(id) do
    Room |> Repo.get!(id)
  end

  def create_room(attrs) do
    %Room{} |> Room.changeset(attrs) |> Repo.insert()
  end
end
