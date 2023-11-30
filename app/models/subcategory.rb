#/workspaces/Inventory-Management-System/app/models/subcategory.rb
# == Schema Information
#
# Table name: subcategories
#
#  id          :integer          not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer          not null
#  company_id  :integer
#
# Indexes
#
#  index_subcategories_on_category_id  (category_id)
#  index_subcategories_on_company_id   (company_id)
#
# Foreign Keys
#
#  category_id  (category_id => categories.id)
#  company_id   (company_id => companies.id)
#
class Subcategory < ApplicationRecord
  belongs_to :category
  has_many :products
  belongs_to :company
  include Ransackable
end
