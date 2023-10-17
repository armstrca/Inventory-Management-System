json.extract! order_item, :id, :quantity_ordered_id, :unit_price_id, :shipping_cost_id, :created_at, :updated_at
json.url order_item_url(order_item, format: :json)
