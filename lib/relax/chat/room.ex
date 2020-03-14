defmodule Relax.Chat.Room do
  use Ecto.Schema
  import Ecto.Changeset
  alias Relax.Chat.Room
  alias Relax.Accounts.User

  schema "rooms" do
    field :name, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Room{} = room, attrs \\ %{}) do
    room
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
    |> foreign_key_constraint(:user_id)
  end
end
