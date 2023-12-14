# frozen_string_literal: true

# /workspaces/Inventory-Management-System/db/migrate/2_create_subcategories.rb
# /workspaces/Inventory-Management-System/db/migrate/20231108164014_create_subcategories.rb
# /workspaces/Inventory-Management-System/db/migrate/20231108164014_create_subcategories.rb
class CreateSubcategories < ActiveRecord::Migration[7.0]
  def change
    create_table(:subcategories) do |t|
      t.string(:name)
      t.text(:description)
      t.references(:category, null: false, foreign_key: true)

      t.timestamps
    end
  end
end
