# == Schema Information
#
# Table name: products
#
#  id             :integer          not null, primary key
#  description    :string
#  name           :string
#  price          :decimal(, )
#  sku            :integer
#  stock_quantity :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  category_id_id :integer          not null
#
# Indexes
#
#  index_products_on_category_id_id  (category_id_id)
#
# Foreign Keys
#
#  category_id_id  (category_id_id => category_ids.id)
#
class Product < ApplicationRecord
  belongs_to :category_id
end
