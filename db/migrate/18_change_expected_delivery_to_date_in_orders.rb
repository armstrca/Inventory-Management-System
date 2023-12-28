# frozen_string_literal: true

# /workspaces/Inventory-Management-System/db/migrate/18_change_expected_delivery_to_date_in_orders.rb
# /workspaces/Inventory-Management-System/db/migrate/20231111024917_change_expected_delivery_to_date_in_orders.rb
# /workspaces/Inventory-Management-System/db/migrate/20231111024917_change_expected_delivery_to_date_in_orders.rb
class ChangeExpectedDeliveryToDateInOrders < ActiveRecord::Migration[6.0]
  def change
    change_column(:orders, :expected_delivery, :date)
  end
end
