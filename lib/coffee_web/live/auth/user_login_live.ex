defmodule CoffeeWeb.Auth.UserLoginLive do
  use CoffeeWeb, :live_view
  import UI.Molecules.Header, only: [ui_header: 1]

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm">
      <.ui_header>
        Log in to account
        <:subtitle>
          Don't have an account?
          <.link navigate={~p"/auth/users/register"} class="font-semibold text-brand hover:underline">
            create one
          </.link>
          now
        </:subtitle>
      </.ui_header>

      <.simple_form for={@form} id="login_form" action={~p"/auth/users/login"} phx-update="ignore">
        <.input field={@form[:email]} type="email" label="Email" required />
        <.input field={@form[:password]} type="password" label="Password" required />

        <:actions>
          <.input field={@form[:remember_me]} type="checkbox" label="Keep me logged in" />
          <.link href={~p"/auth/users/reset_password"} class="text-sm font-semibold">
            Forgot your password?
          </.link>
        </:actions>
        <:actions>
          <.button phx-disable-with="Logging in..." class="w-full">
            Log in <span aria-hidden="true">→</span>
          </.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    email = Phoenix.Flash.get(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end
