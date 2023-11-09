class AddOrderIdToProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :order, null: false, foreign_key: true
  end
end
