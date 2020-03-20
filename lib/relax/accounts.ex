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

  def authenticate_by_username_and_password(username, password) do
    query = from u in User, where: u.name == ^username

    user = Repo.one(query)

    cond do
      user && Argon2.verify_pass(password, user.password_digest) -> {:ok, user}
      true -> {:error, :unauthorized}
    end
  end
end
