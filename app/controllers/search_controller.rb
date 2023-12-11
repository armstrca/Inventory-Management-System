#/workspaces/Inventory-Management-System/app/controllers/search_controller.rb
class SearchController < ApplicationController
  def index
    @q = params[:q]
    @results = perform_search
    @products = @results[:products] || []
    @categories = @results[:categories] || []
    @subcategories = @results[:subcategories] || []
    @order_products = @results[:order_products] || []
    @orders = @results[:orders] || []
    @storage_locations = @results[:storage_locations] || []
    @suppliers = @results[:suppliers] || []
    @users = @results[:users] || []
  end

  private

  def perform_search
    # Use Ransack to search across multiple models

    results = {}

    # Search in 'categories' model
    results[:categories] = Category.ransack(name_or_description_cont: @q).result.to_a

    # Search in 'products' model
    results[:products] = Product.ransack(name_or_description_cont: @q).result.to_a

    # Search in 'orders' model
    results[:orders] = Order.ransack(status_or_description_cont: @q).result.to_a

    # Search in 'subcategories' model
    results[:subcategories] = Subcategory.ransack(name_or_description_cont: @q).result.to_a

    # Search in 'suppliers' model
    results[:suppliers] = Supplier.ransack(name_or_description_or_contact_info_cont: @q).result.to_a

    # Search in 'users' model
    results[:users] = User.ransack(email_or_first_name_or_last_name_or_role_cont: @q).result.to_a

    # Flatten the array of results and remove duplicates
    results.each { |key, value| results[key] = value.flatten.uniq }

    results
  end
end
