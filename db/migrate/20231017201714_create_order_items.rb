class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.references :quantity_ordered, null: false, foreign_key: true
      t.references :unit_price, null: false, foreign_key: true
      t.references :shipping_cost, null: false, foreign_key: true

      t.timestamps
    end
  end
end
