defmodule Category.Product do
  use Ecto.Schema
  use Timex

  schema "products" do
        field(:name, :string)
        field(:price, :string)
        field(:image, :string)
        timestamps(type: :utc_datetime)
  end



  def changeset(product, params \\ %{}) do
    product
      |> Ecto.Changeset.cast(params,[:name, :price])
      |> Ecto.Changeset.validate_required([:name])
  end

  def insert_to_products_table(name, price, image)  do
        Category.Product.changeset(%Category.Product{name: name, price: to_string(price), image: image} )
        |> App.Repo.insert
    end

  def list_products do
    App.Repo.all(Category.Product)
    # IO.puts "#{list.name}"
  end
end
