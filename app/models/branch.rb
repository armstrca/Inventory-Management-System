# frozen_string_literal: true

# /workspaces/Inventory-Management-System/app/models/branch.rb
# == Schema Information
#
# Table name: branches
#
#  id         :integer          not null, primary key
#  address    :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :integer
#
# Indexes
#
#  index_branches_on_company_id  (company_id)
#
# Foreign Keys
#
#  company_id  (company_id => companies.id)
#
class Branch < ApplicationRecord
  belongs_to :company
  has_many :users
  has_many :products
  has_many :order_products
  has_many :reports
  has_many :storage_locations
end
