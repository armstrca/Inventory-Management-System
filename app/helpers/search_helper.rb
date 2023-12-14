# frozen_string_literal: true

# /workspaces/Inventory-Management-System/app/helpers/search_helper.rb
module SearchHelper
  def get_columns_for_model(model, products)
    case model.to_s
    when "User"
      ["id", "first_name", "Email", "Bio", "Role"]
    when "Supplier"
      ["id", "Address", "Contact_Info", "Description", "Name"]
    when "Subcategory"
      ["id", "Description", "Name"]
    when "StorageLocation"
      ["id", "Address", "Description", "Name"]
    when "Product"
      products.map do |product|
        [
          product.id.to_s,
          product.name.to_s,
          product.description.to_s,
          product.sku.to_s,
          number_with_precision(product.price, precision: 2).to_s,
          product.stock_quantity.to_s,
          product.category ? product.category.name.to_s : "",
          product.subcategory ? product.subcategory.name.to_s : "",
          product.supplier ? product.supplier.name.to_s : "",
        ]
      end
    when "Order"
      ["id", "Description", "Expected_Delivery", "Receiving_Address", "Sending_Address", "Products", "Status"]
    when "Category"
      ["id", "Name", "Subcategory", "Description"]
    else
      model_results.first.attributes.keys
    end
  end
end
