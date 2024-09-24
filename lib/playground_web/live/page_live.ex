defmodule PlaygroundWeb.PageLive do
  use PlaygroundWeb, :live_view
  import UI.Alert

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       number: 0,
       form: to_form(%{"add_amount" => 7}),
       modal_open: false
     )}
  end

  def handle_event("add", _params, socket) do
    {:noreply, assign(socket, number: socket.assigns.number + 1)}
  end

  def handle_event("adding_more", %{"add_amount" => amount}, socket) do
    amount =
      case Integer.parse(amount) do
        {number, _} -> number
        :error -> 0
      end

    {:noreply,
     assign(socket,
       number: socket.assigns.number + amount,
       form: to_form(%{"add_amount" => 0})
     )}
  end

  def handle_event("confirm_modal", _params, socket) do
    {:noreply, assign(socket, modal_open: true)}
  end

  def handle_event("close_modal", _params, socket) do
    {:noreply, assign(socket, modal_open: false)}
  end
end
