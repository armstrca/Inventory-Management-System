# frozen_string_literal: true

# /workspaces/Inventory-Management-System/db/migrate/15_add_product_id_to_order_products.rb
# /workspaces/Inventory-Management-System/db/migrate/20231109195908_add_product_id_to_order_products.rb
# /workspaces/Inventory-Management-System/db/migrate/20231109195908_add_product_id_to_order_products.rb
class AddProductIdToOrderProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference(:order_products, :product, null: false, foreign_key: true)
  end
end
