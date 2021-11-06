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
    list = parse_json_data()["items"]
    # [first_item | _] = parse_json_data()["items"] ## list => loop save file / db, get show on UI
    Enum.each(list, fn items -> IO.puts "Items name: #{items["item_basic"]["name"]} && Items Price: #{items["item_basic"]["price"]}  " end)
    # Enum.take(list, 1)
    # Enum.count(list)
    # first_item["item_basic"]["name"]



    Enum.each(list, fn items -> Category.Product.insert_to_db(items["item_basic"]["name"], items["item_basic"]["price"]) end)
    # Category.Product.insert_to_db(list["item_basic"]["name"], list["item_basic"]["price"])
  end

  def get_product_list do
    list = parse_json_data()["items"]
  end
end
