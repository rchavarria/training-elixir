defmodule SocketGallowsWeb.PageController do
  use SocketGallowsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
