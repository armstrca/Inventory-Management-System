# frozen_string_literal: true

# /workspaces/Inventory-Management-System/db/migrate/13_add_address_to_suppliers.rb
# /workspaces/Inventory-Management-System/db/migrate/20231108223954_add_address_to_suppliers.rb
# /workspaces/Inventory-Management-System/db/migrate/20231108223954_add_address_to_suppliers.rb
class AddAddressToSuppliers < ActiveRecord::Migration[7.0]
  def change
    add_column(:suppliers, :address, :string)
  end
end
