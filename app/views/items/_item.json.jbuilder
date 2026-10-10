json.extract! item, :id, :order_id, :quantity, :product_id, :created_at, :updated_at
json.url item_url(item, format: :json)
