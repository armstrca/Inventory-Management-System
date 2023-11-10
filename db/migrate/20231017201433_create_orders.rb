#/workspaces/Inventory-Management-System/db/migrate/20231017201433_create_orders.rb
class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.datetime :expected_delivery
      t.string :status
      t.string :description

      t.timestamps
    end
  end
end
