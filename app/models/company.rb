# frozen_string_literal: true

# /workspaces/Inventory-Management-System/app/models/company.rb
# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Company < ApplicationRecord
  has_many :branches
  has_many :users
  has_many :products
  has_many :order_products
  has_many :reports
  has_many :storage_locations
  has_many :subcategories
  has_many :categories
  has_many :suppliers
end
