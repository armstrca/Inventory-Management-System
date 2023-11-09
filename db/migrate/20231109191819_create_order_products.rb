class CreateOrderProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :order_products do |t|
      t.string :quantity_ordered
      t.float :shipping_cost

      t.timestamps
    end
  end
end
