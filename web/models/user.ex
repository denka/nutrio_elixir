defmodule NutrioElixir.User do
  use Ecto.Model

  @primary_key {:user_id, :integer, []}
  schema "user_master" do
    field :email, :string
    field :cobrand_id, :integer
  end
end
