#/workspaces/Inventory-Management-System/app/models/storage_location.rb
# == Schema Information
#
# Table name: storage_locations
#
#  id          :integer          not null, primary key
#  address     :string
#  description :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class StorageLocation < ApplicationRecord
  include Ransackable
end
