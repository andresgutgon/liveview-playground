defmodule UI.Tokens.Color do
  @type background :: :transparent | :backgroundCode
  @type text_color ::
          :white
          | :primary
          | :foreground
          | :background
          | :foregroundMuted
          | :accent
          | :destructive
          | :destructiveForeground
          | :destructiveMutedForeground
          | :accentForeground
          | :secondaryForeground
          | :warningMutedForeground
  @type border_color :: :transparent | :white | :border

  @spec colors() :: map
  def colors do
    %{
      background: %{
        transparent: "bg-transparent",
        foreground: "bg-foreground",
        foreground_muted: "bg-muted-foreground",
      },
      text_color: %{
        white: "text-white",
        primary: "text-primary",
        foreground: "text-foreground",
        background: "text-background",
        foregroundMuted: "text-muted-foreground",
        accent: "text-accent",
        destructive: "text-destructive",
        destructiveForeground: "text-destructive-foreground",
        destructiveMutedForeground: "text-destructive-muted-foreground",
        accentForeground: "text-accent-foreground",
        secondaryForeground: "text-secondary-foreground",
        warningMutedForeground: "text-warning-muted-foreground"
      },
      border_color: %{
        transparent: "border-transparent",
        white: "border-white",
        border: "border-border"
      }
    }
  end

  @spec color(:background | :text_color | :border_color, String.t()) ::
          String.t()
  def color(category, key) when is_binary(key) do
    atom_key = String.to_existing_atom(key)
    color(category, atom_key)
  rescue
    ArgumentError -> raise "Invalid color key: #{key}"
  end

  @spec color(:background | :text_color | :border_color, atom) :: String.t()
  def color(category, key) do
    properties = colors()
    Map.get(properties[category], key)
  end
end
