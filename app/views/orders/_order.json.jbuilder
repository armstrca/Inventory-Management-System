# frozen_string_literal: true

json.extract!(order, :id, :expected_delivery, :status, :description, :created_at, :updated_at)
json.url(order_url(order, format: :json))
