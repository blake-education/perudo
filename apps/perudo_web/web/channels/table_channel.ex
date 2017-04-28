defmodule PerudoWeb.TableChannel do
  use Phoenix.Channel

  def join("table:lobby", _message, socket) do
    {:ok, socket}
  end

  def join("table:game", _params, socket) do
    id = Game.join_table()
    IO.inspect "table:game"
    IO.inspect id
    new_socket = assign(socket, :table_id, id)
    IO.inspect new_socket
    send(self, :after_join)
    {:ok, new_socket}
  end

  def handle_info(:after_join, socket) do
    data = Game.table_state(socket.assigns.table_id)
    IO.inspect socket
    IO.inspect data
    push(socket, "state", data)
    {:noreply, socket}
  end
end
