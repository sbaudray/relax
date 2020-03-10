defmodule Relax.Repo do
  use Ecto.Repo,
    otp_app: :relax,
    adapter: Ecto.Adapters.Postgres
end
