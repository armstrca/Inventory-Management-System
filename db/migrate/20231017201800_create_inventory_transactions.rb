class CreateInventoryTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :inventory_transactions do |t|
      t.string :transaction_type
      t.integer :quantity

      t.timestamps
    end
  end
end
