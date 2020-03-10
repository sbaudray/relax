defmodule RelaxWeb.Router do
  use RelaxWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RelaxWeb do
    pipe_through [:browser]

    get "/", PageController, :index

    get "/user/new", UserController, :new
    post "/user/create", UserController, :create

    get "/session/new", SessionController, :new
    post "/session/create", SessionController, :create

    get "/room/index", RoomController, :index
    get "/room/new", RoomController, :new
    get "/room/show/:room_id", RoomController, :show
    post "/room/create", RoomController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", RelaxWeb do
  #   pipe_through :api
  # end
end
