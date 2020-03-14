defmodule RelaxWeb.RoomView do
  use RelaxWeb, :view

  alias Relax.Accounts.User
  alias Relax.Chat.{Room, Message}

  def message_from_user?(%User{} = user, %Message{} = message) do
    user.id == message.user_id
  end

  def room_owned_by_user?(%User{} = user, %Room{} = room) do
    user.id == room.user_id
  end
end
