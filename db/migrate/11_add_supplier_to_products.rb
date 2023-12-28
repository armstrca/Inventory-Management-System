# frozen_string_literal: true

# /workspaces/Inventory-Management-System/db/migrate/11_add_supplier_to_products.rb
# /workspaces/Inventory-Management-System/db/migrate/20231108165442_add_supplier_to_products.rb
# /workspaces/Inventory-Management-System/db/migrate/20231108165442_add_supplier_to_products.rb
class AddSupplierToProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference(:products, :supplier, null: true, foreign_key: true)
  end
end
