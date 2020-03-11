defmodule Relax.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Relax.Chat.{Message, Room}
  alias Relax.Accounts.User

  schema "messages" do
    field :body, :string
    belongs_to :user, User
    belongs_to :room, Room

    timestamps()
  end

  @doc false
  def changeset(%Message{} = message, attrs \\ %{}) do
    message
    |> cast(attrs, [:body, :user_id, :room_id])
    |> validate_required([:body, :user_id, :room_id])
    |> foreign_key_constraint(:room_id)
    |> foreign_key_constraint(:user_id)
  end
end

