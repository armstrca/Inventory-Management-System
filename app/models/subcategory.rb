#/workspaces/Inventory-Management-System/app/models/subcategory.rb
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
#
# Indexes
#
#  index_subcategories_on_category_id  (category_id)
#
# Foreign Keys
#
#  category_id  (category_id => categories.id)
#
class Subcategory < ApplicationRecord
  belongs_to :category
  has_many :products
  include Ransackable
end
