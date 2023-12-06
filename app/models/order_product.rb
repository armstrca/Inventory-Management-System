# == Schema Information
#
# Table name: order_products
#
#  id               :integer          not null, primary key
#  quantity_ordered :integer
#  shipping_cost    :float
#  transaction_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  order_id         :integer          not null
#  product_id       :integer          not null
#
# Indexes
#
#  index_order_products_on_order_id    (order_id)
#  index_order_products_on_product_id  (product_id)
#
# Foreign Keys
#
#  order_id    (order_id => orders.id)
#  product_id  (product_id => products.id)
#
class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product
  include Ransackable
  validate :validate_quantity_ordered

  after_save :update_product_stock_quantity

  private

  def update_product_stock_quantity
    product.update!(stock_quantity: product.calculate_dynamic_stock_quantity)
  end

  def validate_quantity_ordered
    if quantity_ordered.present? &&
        (transaction_type == 'sale_to_customer' ||
         transaction_type == 'return_to_supplier' ||
         transaction_type == 'stock_loss') &&
        quantity_ordered > product.stock_quantity
      errors.add(:quantity_ordered, "cannot be greater than available stock quantity (#{product.stock_quantity})")
    end
  end

end
