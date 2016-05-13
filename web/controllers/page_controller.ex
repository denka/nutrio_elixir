defmodule NutrioElixir.PageController do
  use NutrioElixir.Web, :controller
  
  plug :require_user
  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
  
  defp require_user(conn, _params) do
    assign(conn, :something, :some_data)
  end
end
