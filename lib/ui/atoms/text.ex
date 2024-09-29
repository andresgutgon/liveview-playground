defmodule UI.Atoms.Text do
  use UI, :component

  @doc """
  Render text component

  ## Examples

      <UI.Text.text size="h1">
        Text content
      </UI.Text.text>
  """

  attr :tag, :string, default: "span"
  attr :size, :string, default: "h4", values: ~w(h1 h2 h3 h4 h5 h6)
  attr :color, :string, default: "foreground"
  attr :dark_color, :string, default: nil
  attr :theme, :string, default: nil
  attr :spacing, :string, default: "normal"
  attr :weight, :string, default: "normal"
  attr :display, :string, default: "inline"
  attr :uppercase, :boolean, default: false
  attr :align, :string, default: "left"
  attr :capitalize, :boolean, default: false
  attr :white_space, :string, default: "normal"
  attr :word_break, :string, default: "normal"
  attr :ellipsis, :boolean, default: false
  attr :user_select, :boolean, default: true
  attr :no_wrap, :boolean, default: false
  attr :underline, :boolean, default: false
  attr :line_through, :boolean, default: false
  attr :monospace, :boolean, default: false
  attr :centered, :boolean, default: false
  attr :animate, :boolean, default: false
  slot :inner_block, required: true
  attr :rest, :global, default: %{}

  def ui_text(assigns) do
    assigns =
      assign(
        assigns,
        :css_classes,
        classes([
          assigns[:size],
          assigns[:weight],
          assigns[:spacing],
          if(assigns[:theme] == "dark",
            do: assigns[:dark_color],
            else: assigns[:color]
          ),
          assigns[:word_break],
          assigns[:white_space],
          assigns[:align],
          assigns[:display],
          if(assigns[:animate], do: "animate-text-gradient", else: ""),
          if(assigns[:capitalize], do: "capitalize", else: ""),
          if(assigns[:uppercase], do: "uppercase", else: ""),
          if(assigns[:ellipsis], do: "truncate", else: ""),
          if(assigns[:user_select], do: "select-none", else: ""),
          if(assigns[:no_wrap], do: "whitespace-nowrap", else: ""),
          if(assigns[:underline], do: "underline", else: ""),
          if(assigns[:line_through], do: "line-through", else: ""),
          if(assigns[:monospace], do: "font-mono", else: "font-sans"),
          if(assigns[:centered], do: "text-center", else: "")
        ])
      )

    ~H"""
    <.dynamic_tag name={@tag} class={@css_classes} {@rest}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
  end
end
