#/workspaces/Inventory-Management-System/app/models/supplier.rb
# == Schema Information
#
# Table name: suppliers
#
#  id           :integer          not null, primary key
#  address      :string
#  contact_info :string
#  description  :string
#  name         :string
#  standing     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Supplier < ApplicationRecord
end
