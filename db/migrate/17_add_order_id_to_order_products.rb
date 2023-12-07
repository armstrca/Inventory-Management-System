#/workspaces/Inventory-Management-System/db/migrate/17_add_order_id_to_order_products.rb
#/workspaces/Inventory-Management-System/db/migrate/20231109193717_add_order_id_to_order_products.rb
#/workspaces/Inventory-Management-System/db/migrate/20231109193717_add_order_id_to_order_products.rb
class AddOrderIdToOrderProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :order_products, :order, null: false, foreign_key: true
  end
end
