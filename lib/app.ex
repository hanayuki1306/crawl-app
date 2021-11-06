defmodule App do
  require HTTPoison
  use Ecto.Schema

  def create_url do
    "https://shopee.vn/api/v4/search/search_items?by=pop&limit=30&match_id=88201679&newest=0&order=desc&page_type=shop&scenario=PAGE_OTHERS&version=2"
  end

  def http_request_data do
    HTTPoison.start()
    HTTPoison.get!(create_url()).body
  end

  def parse_json_data do
    Poison.Parser.parse!(http_request_data())
  end

  def insert_to_db do
    App.Repo.delete_all(Category.Product)
    list = parse_json_data()["items"]

    Enum.each(list, fn items -> IO.puts "Items name: #{items["item_basic"]["name"]} && Items Price: #{items["item_basic"]["price"]} && image: #{items["item_basic"]["image"]} " end)

    Enum.each(list, fn items -> Category.Product.insert_to_products_table(items["item_basic"]["name"], div( items["item_basic"]["price"], 100000), "https://cf.shopee.vn/file/#{items["item_basic"]["image"]}") end)

  end

  def get_list_product do
    insert_to_db()
    Category.Product.list_products
  end
end
