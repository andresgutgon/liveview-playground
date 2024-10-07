defmodule CoffeeWeb.Auth.UserLoginLive do
  use CoffeeWeb, :live_view
  alias UI.Molecules.Header, as: Header
  alias UI.Atoms.Form, as: Form
  alias UI.Atoms.Input, as: Input

  def mount(_params, _session, socket) do
    email = Phoenix.Flash.get(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm flex flex-col gap-y-6">
      <Header.c>
        Log in to account
        <:subtitle>
          Don't have an account?
          <.link
            navigate={~p"/auth/users/register"}
            class="font-semibold text-brand hover:underline"
          >
            create one
          </.link>
          now
        </:subtitle>
      </Header.c>
      <Form.c
        for={@form}
        id="login_form"
        action={~p"/auth/users/login"}
        phx-update="ignore"
      >
        <Input.c
          field={@form[:email]}
          type="email"
          label="Email"
          placeholder="Your email"
          required
        />
        <Input.c
          field={@form[:password]}
          type="password"
          label="Password"
          placeholder="*********"
          description="Your password must be at least 8 characters long."
          required
        />

        <div class="flex items-center justify-between gap-6">
          <Input.c
            field={@form[:remember_me]}
            type="checkbox"
            label="Keep me logged in"
          />
          <.link href={~p"/auth/users/reset_password"} class="flex-shrink-0 text-sm font-semibold">
            Forgot your password?
          </.link>
        </div>
        <div class="mt-2 flex items-center justify-between gap-6">
          <.button phx-disable-with="Logging in..." class="w-full">
            Go to your account
          </.button>
        </div>
      </Form.c>
    </div>
    """
  end
end
