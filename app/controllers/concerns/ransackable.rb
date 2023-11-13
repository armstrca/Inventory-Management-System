#/workspaces/Inventory-Management-System/app/controllers/concerns/ransackable.rb
# app/models/concerns/ransackable.rb
module Ransackable
  extend ActiveSupport::Concern

  included do
    def self.ransackable_associations(auth_object = nil)
      column_names
    end
    def self.ransackable_attributes(auth_object = nil)
      column_names
    end
  end
end
