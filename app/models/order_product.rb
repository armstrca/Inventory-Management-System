#/workspaces/Inventory-Management-System/app/models/order_product.rb
#/workspaces/Inventory-Management-System/app/models/order_product.rb
# == Schema Information
#
# Table name: order_products
#
#  id               :integer          not null, primary key
#  quantity_ordered :integer
#  shipping_cost    :float
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  branch_id        :integer
#  company_id       :integer
#  order_id         :integer          not null
#  product_id       :integer          not null
#
# Indexes
#
#  index_order_products_on_branch_id   (branch_id)
#  index_order_products_on_company_id  (company_id)
#  index_order_products_on_order_id    (order_id)
#  index_order_products_on_product_id  (product_id)
#
# Foreign Keys
#
#  branch_id   (branch_id => branches.id)
#  company_id  (company_id => companies.id)
#  order_id    (order_id => orders.id)
#  product_id  (product_id => products.id)
#
class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product
  belongs_to :company
  belongs_to :branch
  include Ransackable
end
