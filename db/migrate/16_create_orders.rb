#/workspaces/Inventory-Management-System/db/migrate/20231017201433_create_orders.rb
#/workspaces/Inventory-Management-System/db/migrate/20231017201433_create_orders.rb
class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.datetime :expected_delivery
      t.string :status
      t.string :description
      t.string :sending_address
      t.string :receiving_address
      t.timestamps
    end

    add_index :orders, :receiving_address
    add_index :orders, :sending_address
    add_index :orders, :expected_delivery
  end
end
