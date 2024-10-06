defmodule UI.Atoms.FormField do
  use UI, :component
  alias UI.Atoms.Label, as: Label
  alias UI.Atoms.Text, as: Text

  @doc """
  Render form control

  ## Examples
      <UI.Atoms.FormControl.form_field label="Email">
        <.input type="text" />
      </UI.Atoms.FormControl.form_field>
  """

  attr :id, :string, required: true
  attr :label, :string, default: ""
  attr :errors, :list, default: []
  attr :class, :string, default: ""
  attr :description, :string, default: ""
  attr :rest, :global, default: %{}

  slot :inner_block, required: true

  def c(assigns) do
    assigns =
      assign_aria_attributes(assigns)
      |> Map.put(:error, assigns[:errors] |> Enum.join(", "))

    debug("ERRORS: #{assigns[:error]}")

    ~H"""
    <div
      class={classes(["space-y-2 w-full", assigns[:class]])}
      aria-describedby={assigns[:aria_describedby]}
      aria-invalid={assigns[:aria_invalid]}
      {@rest}
    >
      <%= if @label do %>
        <Label.c for={@id}><%= @label %></Label.c>
      <% end %>

      <.form_control
        id={@id}
        error={@error}
        aria_invalid={@aria_invalid}
        aria_describedby={@aria_describedby}
      >
        <%= render_slot(@inner_block) %>
      </.form_control>

      <Text.h5
        :if={@description != ""}
        tag="p"
        id={assigns[:form_description_id]}
        color="foreground_muted"
      >
        <%= @description %>
      </Text.h5>

      <Text.h7
        :if={@error != ""}
        tag="p"
        id={assigns[:form_message_id]}
        color="destructive"
      >
        <%= @error %>
      </Text.h7>
    </div>
    """
  end

  attr :id, :string, required: true
  attr :aria_describedby, :string, default: ""
  attr :aria_invalid, :string, default: "false"
  attr :error, :string, default: nil
  slot :inner_block, required: true

  defp form_control(assigns) do
    ~H"""
    <div aria-describedby={@aria_describedby} aria-invalid={@aria_invalid}>
      <%= render_slot(@inner_block, %{aria_invalid: @aria_invalid}) %>
    </div>
    """
  end

  attr :error, :string, default: nil

  defp assign_aria_attributes(assigns) do
    id = assigns[:id]
    form_description_id = "#{id}-form-item-description"
    form_message_id = "#{id}-form-item-message"

    assigns
    |> Map.put(:form_message_id, form_message_id)
    |> Map.put(:form_description_id, form_description_id)
    |> Map.put(:aria_invalid, if(assigns[:error], do: "true", else: "false"))
    |> Map.put(
      :aria_describedby,
      if(assigns[:error],
        do: form_message_id,
        else: "#{form_description_id} #{form_message_id}"
      )
    )
  end
end
