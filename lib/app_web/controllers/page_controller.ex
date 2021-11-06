defmodule AppWeb.PageController do
  use AppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end


  def showProduct(conn, _params) do
    message = App.get_product_list
    render(conn, "show.html", message: message )
  end
end