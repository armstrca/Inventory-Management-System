# frozen_string_literal: true

# /workspaces/Inventory-Management-System/db/migrate/20_create_branches.rb
# db/migrate/[timestamp]_create_branches.rb
class CreateBranches < ActiveRecord::Migration[7.0]
  def change
    create_table(:branches) do |t|
      t.string(:name)
      t.references(:company, foreign_key: true)
      t.string(:address)
      t.timestamps
    end
  end
end
