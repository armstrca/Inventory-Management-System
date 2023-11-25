#/workspaces/Inventory-Management-System/app/models/storage_location.rb
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
#  branch_id   :integer
#  company_id  :integer
#
# Indexes
#
#  index_storage_locations_on_branch_id   (branch_id)
#  index_storage_locations_on_company_id  (company_id)
#
# Foreign Keys
#
#  branch_id   (branch_id => branches.id)
#  company_id  (company_id => companies.id)
#
class StorageLocation < ApplicationRecord
  belongs_to :company
  belongs_to :branch
  include Ransackable
end
