defmodule RelaxWeb.RoomChannel do
  use Phoenix.Channel
  alias Relax.Chat

  def join(_room_id, _params, socket) do
    {:ok, socket}
  end

  def handle_in("new_message", %{"body" => body}, socket) do
    "room:" <> room_id = socket.topic

    {:ok, _} =
      Chat.create_message(%{body: body, room_id: room_id, user_id: socket.assigns.current_user_id})

    broadcast!(socket, "new_message", %{body: body})
    {:noreply, socket}
  end
end
