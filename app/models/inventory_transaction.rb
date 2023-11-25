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
#  branch_id        :integer
#  company_id       :integer
#
# Indexes
#
#  index_inventory_transactions_on_branch_id   (branch_id)
#  index_inventory_transactions_on_company_id  (company_id)
#
# Foreign Keys
#
#  branch_id   (branch_id => branches.id)
#  company_id  (company_id => companies.id)
#
class InventoryTransaction < ApplicationRecord
  belongs_to :company
  belongs_to :branch
  include Ransackable
end
