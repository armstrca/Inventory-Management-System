# frozen_string_literal: true

json.extract!(supplier, :id, :name, :contact_info, :description, :standing, :created_at, :updated_at)
json.url(supplier_url(supplier, format: :json))
