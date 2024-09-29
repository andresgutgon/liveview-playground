defmodule UI.Molecules.Header do
  use UI, :component
  import UI.Atoms.Text, only: [ui_text: 1]

  attr :class, :string, default: nil
  slot :inner_block, required: true
  slot :subtitle
  slot :actions

  def ui_header(assigns) do
    ~H"""
    <header class={[
      @actions != [] && "flex items-center justify-between gap-6",
      @class
    ]}>
      <div>
        <.ui_text size="h1" tag="h1"><%= render_slot(@inner_block) %></.ui_text>
        <.ui_text :if={@subtitle != []} size="h5" tag="p">
          <%= render_slot(@subtitle) %>
        </.ui_text>
      </div>
      <div class="flex-none"><%= render_slot(@actions) %></div>
    </header>
    """
  end
end
