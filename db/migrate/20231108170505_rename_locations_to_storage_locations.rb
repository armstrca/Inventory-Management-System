class RenameLocationsToStorageLocations < ActiveRecord::Migration[7.0]
  def change
    rename_table :locations, :storage_locations
  end
end
