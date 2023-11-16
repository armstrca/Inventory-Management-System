#/workspaces/Inventory-Management-System/app/controllers/search_controller.rb
#/workspaces/Inventory-Management-System/app/controllers/search_controller.rb
# app/controllers/search_controller.rb
class SearchController < ApplicationController
  def index
    @q = params[:q]
    @results = perform_search
    @products = Product.all
    @categories = Category.all
    @inventory_transactions = InventoryTransaction.all
    @order_products = OrderProduct.all
    @orders = Order.all
    @storage_locations = StorageLocation.all
    @suppliers = Supplier.all
    @users = User.all
  end

  private

  def perform_search
    # Use Ransack to search across multiple models

    results = []

    # Search in 'categories' model
    results << Category.ransack(name_or_description_cont: @q).result

    # Search in 'inventory_transactions' model
    results << InventoryTransaction.ransack(transaction_type_cont: @q).result

    # Search in 'order_products' model
    results << OrderProduct.ransack(quantity_ordered_cont: @q).result

    # Search in 'orders' model
    results << Order.ransack(status_or_description_cont: @q).result

    # Search in 'products' model
    results << Product.ransack(name_or_description_cont: @q).result

    # Search in 'reports' model
    # results << Report.ransack(report_type_or_data_criteria_cont: @q).result

    # Search in 'storage_locations' model
    results << StorageLocation.ransack(name_or_description_cont: @q).result

    # Search in 'subcategories' model
    results << Subcategory.ransack(name_or_description_cont: @q).result

    # Search in 'suppliers' model
    results << Supplier.ransack(name_or_description_or_contact_info_cont: @q).result

    # Search in 'users' model
    results << User.ransack(email_or_first_name_or_last_name_or_role_cont: @q).result

    # Flatten the array of results and remove duplicates
    results.flatten.uniq
  end
end
