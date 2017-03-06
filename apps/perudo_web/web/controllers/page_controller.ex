defmodule PerudoWeb.PageController do
  use PerudoWeb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
