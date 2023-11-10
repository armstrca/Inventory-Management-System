#/workspaces/Inventory-Management-System/app/models/product.rb
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
#  category_id    :integer          not null
#  order_id       :integer          not null
#  subcategory_id :integer          not null
#  supplier_id    :integer          not null
#
# Indexes
#
#  index_products_on_category_id     (category_id)
#  index_products_on_order_id        (order_id)
#  index_products_on_subcategory_id  (subcategory_id)
#  index_products_on_supplier_id     (supplier_id)
#
# Foreign Keys
#
#  category_id     (category_id => categories.id)
#  order_id        (order_id => orders.id)
#  subcategory_id  (subcategory_id => subcategories.id)
#  supplier_id     (supplier_id => suppliers.id)
#
class Product < ApplicationRecord
  belongs_to :category
  belongs_to :subcategory
  belongs_to :supplier
  belongs_to :order
  has_many :order_products
end
