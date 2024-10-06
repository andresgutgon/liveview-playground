defmodule UI.Atoms.Label do
  alias UI.Atoms.Text, as: Text
  use UI, :component

  attr :for, :string, required: true
  attr :variant, :string, default: "default"
  attr :class, :string, default: ""
  attr :rest, :global, default: %{}

  slot :inner_block, required: true

  def c(assigns) do
    ~H"""
    <Text.h5
      tag="label"
      color={if @variant == "destructive", do: "destructure", else: "foreground"}
      class={
        classes([
          "peer-disabled:cursor-not-allowed peer-disabled:opacity-70",
          assigns[:class]
        ])
      }
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </Text.h5>
    """
  end
end
