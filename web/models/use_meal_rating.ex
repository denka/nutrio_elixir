defmodule NutrioElixir.UserMealRating do
  use Ecto.Model

  @primary_key {:rating_id, :integer, []}
  @derive {Poison.Encoder, only: [:rating_id, :meal_id, :value]}
  schema "ic_meal_rating_user" do
    field :meal_id, :integer
    field :user_id, :integer
    field :value, :decimal
  end
end
