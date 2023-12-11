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
#  branch_id      :integer
#  category_id    :integer          not null
#  company_id     :integer
#  subcategory_id :integer          not null
#  supplier_id    :integer
#
# Indexes
#
#  index_products_on_branch_id                        (branch_id)
#  index_products_on_category_id                      (category_id)
#  index_products_on_company_and_branch_and_category  (company_id,branch_id,category_id)
#  index_products_on_company_id                       (company_id)
#  index_products_on_subcategory_id                   (subcategory_id)
#  index_products_on_supplier_id                      (supplier_id)
#
# Foreign Keys
#
#  branch_id       (branch_id => branches.id)
#  category_id     (category_id => categories.id)
#  company_id      (company_id => companies.id)
#  subcategory_id  (subcategory_id => subcategories.id)
#  supplier_id     (supplier_id => suppliers.id)
#
class Product < ApplicationRecord
  belongs_to :company
  has_many :branches
  belongs_to :category
  belongs_to :subcategory
  belongs_to :supplier
  has_many :order_products, dependent: :destroy
  has_many :orders, through: :order_products, dependent: :destroy
  include Ransackable

  def calculate_dynamic_stock_quantity
    starting_stock = product.stock_quantity
    starting_stock + order_products.sum do |order_product|
      case order_product.transaction_type
      when "purchase_from_supplier", "refund_to_customer"
        order_product.quantity_ordered
      when "sale_to_customer", "return_to_supplier", "stock_loss"
        -order_product.quantity_ordered
      else
        0
      end
    end
  end

  def supplier_name
    supplier&.name
  end

  def category_name
    category&.name
  end

  def subcategory_name
    subcategory&.name
  end
end
