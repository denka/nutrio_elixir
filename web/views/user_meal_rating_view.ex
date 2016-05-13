defmodule NutrioElixir.UserMealRatingView do
  use NutrioElixir.Web, :view

  def render("index.json", %{user_meal_ratings: user_meal_ratings}) do
    user_meal_ratings
  end
end
