require Logger

defmodule UI.Tokens.Display do
  @type display :: :block | :inline | :inline_block

  @spec properties() :: map
  def properties do
    %{
      block: "block",
      inline: "inline",
      inline_block: "inline-block"
    }
  end

  @spec display(:display, String.t()) :: String.t()
  def display(category, key) when is_binary(key) do
    atom_key = String.to_existing_atom(key)
    display(category, atom_key)
  rescue
    ArgumentError -> raise "Invalid display key: #{key}"
  end

  @spec display(:display, display) :: String.t()
  def display(category, key) do
    properties()[key]
  end
end
