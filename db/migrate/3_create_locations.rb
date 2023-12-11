#/workspaces/Inventory-Management-System/db/migrate/3_create_locations.rb
#/workspaces/Inventory-Management-System/db/migrate/20231017202033_create_locations.rb
#/workspaces/Inventory-Management-System/db/migrate/20231017202033_create_locations.rb
class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :description
      t.string :address

      t.timestamps
    end
  end
end
