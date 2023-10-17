# == Schema Information
#
# Table name: order_items
#
#  id                  :integer          not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  quantity_ordered_id :integer          not null
#  shipping_cost_id    :integer          not null
#  unit_price_id       :integer          not null
#
# Indexes
#
#  index_order_items_on_quantity_ordered_id  (quantity_ordered_id)
#  index_order_items_on_shipping_cost_id     (shipping_cost_id)
#  index_order_items_on_unit_price_id        (unit_price_id)
#
# Foreign Keys
#
#  quantity_ordered_id  (quantity_ordered_id => quantity_ordereds.id)
#  shipping_cost_id     (shipping_cost_id => shipping_costs.id)
#  unit_price_id        (unit_price_id => unit_prices.id)
#
class OrderItem < ApplicationRecord
  belongs_to :quantity_ordered
  belongs_to :unit_price
  belongs_to :shipping_cost
end
