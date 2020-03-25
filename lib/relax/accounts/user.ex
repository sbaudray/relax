defmodule Relax.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Relax.Accounts.User

  schema "users" do
    field :name, :string
    field :password_digest, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name, :password_digest])
    |> validate_required([:name, :password_digest])
    |> update_change(:password_digest, &Argon2.hash_pwd_salt/1)
    |> unique_constraint(:name)
  end
end
