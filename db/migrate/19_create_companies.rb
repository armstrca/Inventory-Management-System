# frozen_string_literal: true

# /workspaces/Inventory-Management-System/db/migrate/19_create_companies.rb
# db/migrate/[timestamp]_create_companies.rb
class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table(:companies) do |t|
      t.string(:name)
      t.timestamps
    end
  end
end
