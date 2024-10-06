defmodule UI.Atoms.Text do
  use UI, :component
  import UI.Tokens.Font, only: [font: 2]
  import UI.Tokens.Display, only: [display: 2]
  import UI.Tokens.Color, only: [color: 2]

  @doc """
  Render text component

  ## Examples

      <UI.Text.text size="h1">
        Text content
      </UI.Text.text>
  """

  attr :tag, :string, default: "span"
  attr :size, :string, default: "h4", values: ~w(h1 h2 h3 h4 h5 h6)
  attr :family, :string, default: "sans", values: ~w(sans mono)
  attr :align, :string, default: "left"
  attr :color, :string, default: "foreground"
  attr :tracking, :string, default: "normal"
  attr :weight, :string, default: "normal"
  attr :display, :string, default: "inline"
  attr :white_space, :string, default: "normal"
  attr :word_break, :string, default: "normal"
  attr :uppercase, :boolean, default: false
  attr :capitalize, :boolean, default: false
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
          color(:text_color, assigns[:color]),
          font(:size, assigns[:size]),
          font(:family, assigns[:family]),
          font(:weight, assigns[:weight]),
          font(:align, assigns[:align]),
          font(:tracking, assigns[:tracking]),
          font(:white_space, assigns[:white_space]),
          font(:word_break, assigns[:word_break]),
          display(:display, assigns[:display]),
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
