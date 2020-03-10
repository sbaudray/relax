defmodule Relax.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Relax.Chat.{Message, Room}
  alias Relax.Accounts.User

  schema "messages" do
    field :content, :string
    belongs_to :user, User
    belongs_to :room, Room

    timestamps()
  end

  @doc false
  def changeset(%Message{} = message, attrs \\ %{}) do
    message |> cast(attrs, [:content]) |> validate_required([:content])
  end
end

