#/workspaces/Inventory-Management-System/app/models/category.rb
#/workspaces/Inventory-Management-System/app/models/category.rb
# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  description :string
#  name        :string
#  subcategory :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  company_id  :integer
#
# Indexes
#
#  index_categories_on_company_id  (company_id)
#
# Foreign Keys
#
#  company_id  (company_id => companies.id)
#
class Category < ApplicationRecord
  has_many :products
  has_many :subcategories
  belongs_to :company
  include Ransackable
end
