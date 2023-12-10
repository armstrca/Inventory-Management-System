#/workspaces/Inventory-Management-System/db/migrate/20231108170505_rename_locations_to_storage_locations.rb
#/workspaces/Inventory-Management-System/db/migrate/20231108170505_rename_locations_to_storage_locations.rb
class RenameLocationsToStorageLocations < ActiveRecord::Migration[7.0]
  def change
    rename_table :locations, :storage_locations
  end
end
