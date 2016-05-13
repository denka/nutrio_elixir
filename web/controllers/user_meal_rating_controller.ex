defmodule NutrioElixir.UserMealRatingController do
  use NutrioElixir.Web, :controller
  alias NutrioElixir.Repo
  alias NutrioElixir.UserMealRating

  # plug :action

  def index(conn, _params) do
    user_meal_ratings = Repo.all(
      from p in UserMealRating, 
        where: p.user_id == 7404337
    )
    render conn, user_meal_ratings: user_meal_ratings
  end
end
