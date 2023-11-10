#/workspaces/Inventory-Management-System/db/migrate/20231102194322_add_sending_and_receiving_address_to_orders.rb
class AddSendingAndReceivingAddressToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :sending_address, :string
    add_column :orders, :receiving_address, :string
  end
end
