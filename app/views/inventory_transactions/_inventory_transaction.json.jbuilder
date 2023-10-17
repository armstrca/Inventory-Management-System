json.extract! inventory_transaction, :id, :transaction_type, :quantity, :created_at, :updated_at
json.url inventory_transaction_url(inventory_transaction, format: :json)
