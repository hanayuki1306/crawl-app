defmodule Category.Product do
  use Ecto.Schema
  use Timex

  schema "products" do
        field(:name, :string)
        field(:price, :string)
        timestamps(type: :utc_datetime)
  end



  def changeset(product, params \\ %{}) do
    product
      |> Ecto.Changeset.cast(params,[:name, :price])
      |> Ecto.Changeset.validate_required([:name])
  end

  def insert_to_db(name, price)  do
        Category.Product.changeset(%Category.Product{name: name, price:  to_string(price)} )
        |> App.Repo.insert
    end

end
