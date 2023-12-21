# frozen_string_literal: true

# /workspaces/Inventory-Management-System/db/migrate/1_create_categories.rb
# /workspaces/Inventory-Management-System/db/migrate/20231017200959_create_categories.rb
# /workspaces/Inventory-Management-System/db/migrate/20231017200959_create_categories.rb
class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table(:categories) do |t|
      t.string(:name)
      t.string(:description)
      t.string(:subcategory)

      t.timestamps
    end
  end
end
