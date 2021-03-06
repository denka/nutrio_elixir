defmodule NutrioElixir.UserMealRating do
  use Ecto.Model
  import Ecto.Changeset

  @primary_key {:rating_id, :id, autogenerate: true}
  @derive {Poison.Encoder, only: [:rating_id, :meal_id, :value]}
  schema "ic_meal_rating_user" do
    field :meal_id, :integer
    field :value, :decimal
    field :cobrand_id, :integer
    belongs_to :user, NutrioElixir.User, foreign_key: :user_id
    field :approved, :boolean
  end
  
  def changeset(user_meal_rating, params \\ %{}) do
    user_meal_rating
    |> cast(params, ~w(meal_id value cobrand_id))
    |> unique_constraint([:meal_id, :user_id, :cobrand_id])
    |> validate_number(:value, less_than: 101)
  end
end
