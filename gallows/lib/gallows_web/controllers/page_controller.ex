defmodule GallowsWeb.PageController do
  use GallowsWeb, :controller

  def index(conn, _params) do
    my_assigns = [ produce: "apple", count: 3 ]
    render conn, "index.html", my_assigns
  end
end
