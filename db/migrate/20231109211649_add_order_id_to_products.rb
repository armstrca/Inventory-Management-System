#/workspaces/Inventory-Management-System/db/migrate/20231109211649_add_order_id_to_products.rb
class AddOrderIdToProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :order, null: false, foreign_key: true
  end
end
