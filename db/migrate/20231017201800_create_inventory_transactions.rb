#/workspaces/Inventory-Management-System/db/migrate/20231017201800_create_inventory_transactions.rb
class CreateInventoryTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :inventory_transactions do |t|
      t.string :transaction_type
      t.integer :quantity

      t.timestamps
    end
  end
end
