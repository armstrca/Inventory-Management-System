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
