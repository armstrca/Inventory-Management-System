# frozen_string_literal: true

# /workspaces/Inventory-Management-System/db/migrate/5_create_suppliers.rb
# /workspaces/Inventory-Management-System/db/migrate/20231017201059_create_suppliers.rb
# /workspaces/Inventory-Management-System/db/migrate/20231017201059_create_suppliers.rb
class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table(:suppliers) do |t|
      t.string(:name)
      t.string(:contact_info)
      t.string(:description)

      t.timestamps
    end
  end
end
