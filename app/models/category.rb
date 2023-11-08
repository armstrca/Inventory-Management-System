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
#
class Category < ApplicationRecord
  has_many :products
  has_many :subcategories
end
