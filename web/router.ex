defmodule NutrioElixir.Router do
  use NutrioElixir.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NutrioElixir do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end
  
  scope "/api", NutrioElixir do
    pipe_through :api
    resources "/user_meal_ratings", UserMealRatingController
  end
end
