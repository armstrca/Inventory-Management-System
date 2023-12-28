# frozen_string_literal: true

json.extract!(product, :id, :name, :description, :sku, :price, :stock_quantity, :category_id, :created_at, :updated_at)
json.url(product_url(product, format: :json))
