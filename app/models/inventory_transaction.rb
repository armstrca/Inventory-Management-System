#/workspaces/Inventory-Management-System/app/models/inventory_transaction.rb
#/workspaces/Inventory-Management-System/app/models/inventory_transaction.rb
# == Schema Information
#
# Table name: inventory_transactions
#
#  id               :integer          not null, primary key
#  quantity         :integer
#  transaction_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class InventoryTransaction < ApplicationRecord
  include Ransackable
end
