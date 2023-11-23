#/workspaces/Inventory-Management-System/app/models/order.rb
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
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_orders_on_expected_delivery  (expected_delivery)
#  index_orders_on_receiving_address  (receiving_address)
#  index_orders_on_sending_address    (sending_address)
#
class Order < ApplicationRecord
  has_many :order_products
  has_many :products, through: :order_products
  belongs_to :supplier, optional: true

  def self.incoming
    Order.where(receiving_address: StorageLocation.select(:address)).order(expected_delivery: :asc)
  end

  def self.outgoing
    Order.where(sending_address: StorageLocation.select(:address)).order(expected_delivery: :asc)
  end
  include Ransackable
end
