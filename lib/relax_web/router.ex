defmodule RelaxWeb.Router do
  use RelaxWeb, :router

  alias Relax.Accounts

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :authenticate
    plug :put_user_token
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RelaxWeb do
    pipe_through [:browser]

    get "/", PageController, :index

    resources "/users", UserController, only: [:new, :create]

    resources "/session", SessionController, only: [:new, :create, :delete], singleton: true

    resources "/room", RoomController, only: [:index, :new, :show, :create, :delete]
  end

  defp authenticate(conn, _) do
    if user_id = get_session(conn, :user_id) do
      assign(conn, :current_user, Accounts.get_user!(user_id))
    else
      conn
    end
  end

  defp put_user_token(conn, _) do
    if current_user = conn.assigns[:current_user] do
      token = Phoenix.Token.sign(conn, "user socket", current_user.id)
      assign(conn, :user_token, token)
    else
      conn
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", RelaxWeb do
  #   pipe_through :api
  # end
end
