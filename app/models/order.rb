#/workspaces/Inventory-Management-System/app/models/order.rb
# == Schema Information
#
# Table name: orders
#
#  id                :integer          not null, primary key
#  description       :string
#  expected_delivery :date
#  receiving_address :string
#  sending_address   :string
#  status            :string
#  total             :decimal(, )
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  branch_id         :integer
#  company_id        :integer
#
# Indexes
#
#  index_orders_on_branch_id          (branch_id)
#  index_orders_on_company_id         (company_id)
#  index_orders_on_expected_delivery  (expected_delivery)
#  index_orders_on_receiving_address  (receiving_address)
#  index_orders_on_sending_address    (sending_address)
#
# Foreign Keys
#
#  branch_id   (branch_id => branches.id)
#  company_id  (company_id => companies.id)
#
class Order < ApplicationRecord
  belongs_to :company
  belongs_to :branch, optional: true
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products
  belongs_to :supplier, optional: true

  accepts_nested_attributes_for :order_products, allow_destroy: true

  def calculate_total
    puts "Calculating total for order #{id}"

    self.total = products.sum do |product|
      order_product = order_products.find_by(product_id: product.id)
      unless order_product
        puts "Could not find order_product for product #{product.id} in order #{id}"
      end

      calculate_transaction_amount(order_product) || 0
    end
  end

  def update_product_stock_quantities
    order_products.each do |order_product|
      update_product_stock(order_product.product, order_product.quantity_ordered) if order_product.transaction_type == "purchase_from_supplier" || order_product.transaction_type == "refund_to_customer"
      update_product_stock(order_product.product, -order_product.quantity_ordered) if order_product.transaction_type == "sale_to_customer" || order_product.transaction_type == "stock_loss" || order_product.transaction_type == "return_to_supplier"
    end
  end

  def calculate_transaction_amount(order_product)
    case order_product.transaction_type
    # Positive price values and negative stock values
    when "sale_to_customer", "return_to_supplier"
      order_product_total = order_product.product.price * order_product.quantity_ordered + order_product.shipping_cost
      # Negative price values and positive stock values
    when "purchase_from_supplier", "refund_to_customer", "stock_loss"
      order_product_total = -(order_product.product.price * order_product.quantity_ordered + order_product.shipping_cost)
    else
      order_product_total = 0
    end

    order_product_total
  end

  def update_product_stock(product, quantity)
    product.update!(stock_quantity: product.stock_quantity + quantity)
  end

  scope :incoming, -> { where(type: 'incoming') }
  scope :outgoing, -> { where(type: 'outgoing') }

  def self.incoming
    Order.where(receiving_address: StorageLocation.select(:address)).order(expected_delivery: :asc)
  end

  def self.outgoing
    Order.where(sending_address: StorageLocation.select(:address)).order(expected_delivery: :asc)
  end

  include Ransackable
end
