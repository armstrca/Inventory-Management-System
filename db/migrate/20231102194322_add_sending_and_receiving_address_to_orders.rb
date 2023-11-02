class AddSendingAndReceivingAddressToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :sending_address, :string
    add_column :orders, :receiving_address, :string
  end
end
