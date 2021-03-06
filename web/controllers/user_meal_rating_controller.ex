defmodule NutrioElixir.UserMealRatingController do
  use NutrioElixir.Web, :controller
  alias NutrioElixir.Repo
  alias NutrioElixir.UserMealRating

  # plug :action

  def index(conn, _params) do
    user = Repo.get(NutrioElixir.User, 7404337)
    user_meal_ratings = Repo.all(
      from p in UserMealRating, 
        where: p.user_id == ^user.user_id
    )
    render conn, user_meal_ratings: user_meal_ratings
  end
  
  def show(conn, %{"id" => id}) do
    case Repo.get(UserMealRating, id) do
      user_meal_rating when is_map(user_meal_rating) ->
        render conn, "show.json", user_meal_rating: user_meal_rating
      _ ->
        redirect conn, to: Router.Helpers.page_path(conn, :show, "unauthorized")
    end
  end

  def create(conn, %{"value" => value, "meal_id" => meal_id}) do
    meal_id = String.to_integer(meal_id)
    val = Decimal.new(value)
    user = Repo.get(NutrioElixir.User, 7404337)
    user_meal_rating = %UserMealRating{user_id: user.user_id, meal_id: meal_id, value: val, cobrand_id: user.cobrand_id, approved: true}
    Repo.insert(user_meal_rating)
    render conn, "show.json", user_meal_rating: user_meal_rating
  end

  def update(conn, %{"id" => id, "value" => value}) do
    val = Decimal.new(value)
    user_meal_rating = Repo.get(UserMealRating, id)
    user_meal_rating = %{user_meal_rating | value: val}
    Repo.update(user_meal_rating)
    render conn, "show.json", user_meal_rating: user_meal_rating
  end

  def destroy(conn, %{"id" => id}) do
    user_meal_rating = Repo.get(UserMealRating, id)
    case user_meal_rating do
      user_meal_rating when is_map(user_meal_rating) ->
        Repo.delete(user_meal_rating)
        conn
        |> put_status(201)
        |> json %{location: Router.Helpers.user_path(conn, :index)}
      _ ->
        redirect conn, Router.Helpers.page_path(page: "unauthorized")
    end
  end
end
