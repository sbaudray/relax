defmodule Relax.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :content, :string, null: false
      add :room_id, references(:rooms, on_delete: :delete_all), null: false
      add :user_id, references(:users), null: false

      timestamps()
    end
  end
end
