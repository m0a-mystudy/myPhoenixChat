defmodule MyPhoenixChat.PageController do
  use MyPhoenixChat.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
