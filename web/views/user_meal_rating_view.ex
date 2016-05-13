defmodule NutrioElixir.UserMealRatingView do
  use NutrioElixir.Web, :view

  def render("index.json", %{user_meal_ratings: user_meal_ratings}) do
    user_meal_ratings
  end
  
  def render("show.json", %{user_meal_rating: user_meal_rating}) do
    user_meal_rating
  end
end
