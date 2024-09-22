defmodule PlaygroundWeb.PageLive do
  use PlaygroundWeb, :live_view
  @type word() :: String.t()

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       number: 0,
       form: to_form(%{add_amount: 7})
     )}
  end

  def render(assigns) do
    ~H"""
    <%= @number %>
    <.button phx-click="add">Add</.button>
    <.simple_form for={@form} phx-submit="adding_more" class="mt-9">
    <input type=hidden name=_csrf_token value=<%= get_csrf_token) %>>
      <.input field={@form[:add_amount]} value={@form.params.add_amount} />
      <.button>Add More</.button>
    </.simple_form>
    """
  end

  def handle_event("add", _params, socket) do
    {:noreply, assign(socket, number: socket.assigns.number + 1)}
  end

  def handle_event("adding_more", %{"add_amount" => amount}, socket) do
    amount_to_add_by =
      case Integer.parse(amount) do
        {number, _} -> number
        :error -> 0
      end

    {:noreply,
     assign(socket,
       number: socket.assigns.number + amount_to_add_by,
       form: to_form(%{add_amount: 0})
     )}
  end
end
