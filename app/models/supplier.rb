#/workspaces/Inventory-Management-System/app/models/supplier.rb
# == Schema Information
#
# Table name: suppliers
#
#  id           :integer          not null, primary key
#  address      :string
#  contact_info :string
#  description  :string
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :integer
#
# Indexes
#
#  index_suppliers_on_company_id  (company_id)
#
# Foreign Keys
#
#  company_id  (company_id => companies.id)
#
class Supplier < ApplicationRecord
  has_many :products, dependent: :nullify
  has_many :orders
  belongs_to :company
  include Ransackable
end
