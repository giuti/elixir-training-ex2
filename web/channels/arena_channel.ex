defmodule Countdown.ArenaChannel do
  use Phoenix.Channel
   alias Countdown.Counter

  def join("arenas:lobby", _message, socket) do
    {:ok, %{counter: Counter.value}, socket}
  end

  def handle_in("count", _message, socket) do
    {status, value} = Counter.count
    broadcast! socket, "update",  %{counter: value}
    case status do
      :ok -> {:reply, {:ok, %{won: false, counter: value}}, socket}
      :overflow -> {:reply, {:ok, %{won: true, counter: value}}, socket}
    end
   end
end
