defmodule GallowsWeb.PageView do
  use GallowsWeb, :view

  def plural_off(item, quantity) when quantity < 0 do
    { :safe, "<span style='color: red'>" <> item <> "</span>" }
  end

  def plural_off(item, 0), do: "no " <> item
  def plural_off(item, 1), do: "1 " <> item
  def plural_off(item, quantity), do: Integer.to_string(quantity) <> " " <> item <> "s"
end
