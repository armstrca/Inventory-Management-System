#/workspaces/Inventory-Management-System/db/migrate/20231109191819_create_order_products.rb
class CreateOrderProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :order_products do |t|
      t.integer :quantity_ordered
      t.float :shipping_cost

      t.timestamps
    end
  end
end
