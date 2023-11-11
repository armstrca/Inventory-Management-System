class ChangeExpectedDeliveryToDateInOrders < ActiveRecord::Migration[6.0]
  def change
    change_column :orders, :expected_delivery, :date
  end
end
