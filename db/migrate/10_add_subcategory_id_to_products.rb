#/workspaces/Inventory-Management-System/db/migrate/10_add_subcategory_id_to_products.rb
#/workspaces/Inventory-Management-System/db/migrate/20231108164853_add_subcategory_id_to_products.rb
#/workspaces/Inventory-Management-System/db/migrate/20231108164853_add_subcategory_id_to_products.rb
class AddSubcategoryIdToProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :subcategory, null: false, foreign_key: true
  end
end
