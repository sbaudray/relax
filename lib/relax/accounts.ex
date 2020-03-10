defmodule Relax.Accounts do
  import Ecto.Query
  alias Relax.Repo

  alias Relax.Accounts.User

  def list_users do
    User |> Repo.all()
  end

  def get_user!(id) do
    User |> Repo.get!(id)
  end

  def create_user(attrs) do
    %User{} |> User.changeset(attrs) |> Repo.insert()
  end

  def authenticate_by_name(name) do
    query = from u in User, where: u.name == ^name

    case Repo.one(query) do
      %User{} = user -> {:ok, user}
      nil -> {:error, :unauthorized}
    end
  end
end
