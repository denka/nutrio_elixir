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
        render conn, "show.json", user: user_meal_rating
      _ ->
        redirect conn, to: Router.Helpers.page_path(conn, :show, "unauthorized")
    end
  end

  def create(conn, %{"user_meal_rating" => %{"value" => value}}) do
    user = Repo.get(NutrioElixir.User, 7404337)
    user_meal_rating = %UserMealRating{value: value, user_id: user.id}
    case UserMealRating.validate(user_meal_rating) do
      nil ->
        user_meal_rating = Repo.insert(user_meal_rating)
        render conn, "show.json", user: user_meal_rating
      errors ->
        render conn, "show.json", user: user_meal_rating, errors: errors
    end
  end

  def update(conn, %{"id" => id, "user_meal_rating" => params}) do
    user_meal_rating = Repo.get(UserMealRating, id)
    user = Repo.get(NutrioElixir.User, 7404337)
    user_meal_rating = %{user_meal_rating | value: params["value"]}
    user_meal_rating = %{user_meal_rating | user_id: user.id}

    case UserMealRating.validate(user_meal_rating) do
      nil ->
        Repo.update(user_meal_rating)
        # [g] really hacky way to redirect in the client.. (is there a better way?)
        conn 
        |> put_status(201)
        |> json %{location: Router.Helpers.user_path(conn, :show, user_meal_rating.id) }
      errors ->
        json conn, errors: errors
    end
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
