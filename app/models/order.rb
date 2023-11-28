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
  has_many :order_products
  has_many :products, through: :order_products
  belongs_to :supplier, optional: true

  accepts_nested_attributes_for :order_products, allow_destroy: true

  def self.incoming
    Order.where(receiving_address: StorageLocation.select(:address)).order(expected_delivery: :asc)
  end

  def self.outgoing
    Order.where(sending_address: StorageLocation.select(:address)).order(expected_delivery: :asc)
  end

  include Ransackable
end
