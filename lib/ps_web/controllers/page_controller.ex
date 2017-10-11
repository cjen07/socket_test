defmodule PsWeb.PageController do
  use PsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
