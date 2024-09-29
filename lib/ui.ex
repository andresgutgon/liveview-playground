defmodule UI do
  @moduledoc false
  def component do
    quote do
      use Phoenix.Component

      import UI.Helpers
      # Class helpers like in NodeJS `clx`: https://github.com/zachdaniel/tails
      import Tails, only: [classes: 1]

      alias Phoenix.LiveView.JS
    end
  end

  @doc """
  When used, dispatch to the appropriate macro.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

  defmacro __using__(_) do
    quote do
      import UI.Alert
      import UI.Icon
    end
  end
end
