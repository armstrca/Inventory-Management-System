# db/migrate/[timestamp]_add_company_and_branch_to_models.rb
class AddCompanyAndBranchToModels < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :company, foreign_key: { to_table: :companies }
    add_reference :users, :branch, foreign_key: { to_table: :branches }

    add_reference :products, :company, foreign_key: { to_table: :companies }
    add_reference :products, :branch, foreign_key: { to_table: :branches }

    add_reference :orders, :company, foreign_key: { to_table: :companies }
    add_reference :orders, :branch, foreign_key: { to_table: :branches }

    add_reference :inventory_transactions, :company, foreign_key: { to_table: :companies }
    add_reference :inventory_transactions, :branch, foreign_key: { to_table: :branches }

    add_reference :categories, :company, foreign_key: { to_table: :companies }

    add_reference :subcategories, :company, foreign_key: { to_table: :companies }

    add_reference :reports, :company, foreign_key: { to_table: :companies }
    add_reference :reports, :branch, foreign_key: { to_table: :branches }

    add_reference :order_products, :company, foreign_key: { to_table: :companies }
    add_reference :order_products, :branch, foreign_key: { to_table: :branches }

    add_reference :storage_locations, :company, foreign_key: { to_table: :companies }
    add_reference :storage_locations, :branch, foreign_key: { to_table: :branches }

    add_reference :suppliers, :company, foreign_key: { to_table: :companies }

    # Add references to other relevant tables

    # Update existing indexes to include company_id and branch_id

    # Example: Update products index
    add_index :products, [:company_id, :branch_id, :category_id], name: "index_products_on_company_and_branch_and_category"

    # Example: Update other relevant indexes
    User.update_all(company_id: 1, branch_id: 1)
    Product.update_all(company_id: 1, branch_id: 1)
    Order.update_all(company_id: 1, branch_id: 1)
  end
end
