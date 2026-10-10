json.extract! product, :id, :name, :description, :price, :is_veg, :restaurant_id, :created_at, :updated_at
json.url product_url(product, format: :json)
