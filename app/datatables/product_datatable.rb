#/workspaces/Inventory-Management-System/app/datatables/product_datatable.rb
require "application_datatable"

class ProductDatatable < ApplicationDatatable
  delegate :params, to: :@view

  def as_json(options = {})
    {
      recordsTotal: count,
      recordsFiltered: total_entries,
      data: data,
    }
  end

  private

  def data
    records.map do |product|
      {
        # Assuming `link_to` is a helper method from the view context
        id: link_to(product.id, product),
        name: link_to(product.name, product),
        description: product.description,
        sku: product.sku,
        price: product.price,
        stock_quantity: product.stock_quantity,
        category: link_to(product.category_name, product.category),
        subcategory: link_to(product.subcategory_name, product.subcategory),
        supplier: link_to(product.supplier_name, product.supplier),
        company_id: product.company_id,
      }
    end
  end

  def records
    @records ||= fetch_records
  end

  def fetch_records(counting = false)
    products = Product.joins(:category, :subcategory, :supplier)
                      .select('products.*, categories.name AS category_name, subcategories.name AS subcategory_name, suppliers.name AS supplier_name')

    # When counting, we don't need to sort or paginate
    unless counting
      if params[:order].present?
        products = products.order(sort_column => sort_direction)
      end

      products = products.page(page).per(per_page)
    end

    if params[:search][:value].present?
      search_value = "%#{params[:search][:value]}%"
      products = products.where(search_query, search_value: search_value)
    end

    products
  end

  def search_query
    queries = searchable_columns.map do |column|
      # Use the original column names without 'AS' aliases
      "#{column} LIKE :search_value"
    end
    queries.join(' OR ')
  end

  def sort_column
    columns = %w[
      products.id
      products.name
      products.description
      products.sku
      products.price
      products.stock_quantity
      categories.name
      subcategories.name
      suppliers.name
    ]
    columns[params[:order]['0'][:column].to_i]
  end

  def sort_direction
    %w[asc desc].include?(params[:order]['0'][:dir]) ? params[:order]['0'][:dir] : 'asc'
  end

  def page
    params[:start].to_i / per_page + 1
  end

  def per_page
    params[:length].to_i.positive? ? params[:length].to_i : 10
  end

  def searchable_columns
    @searchable_columns ||= [
      'products.id',
      'products.name',
      'products.description',
      'products.sku',
      'products.price',
      'products.stock_quantity',
      'categories.name', # Alias not needed, just use the column name
      'subcategories.name', # Alias not needed, just use the column name
      'suppliers.name', # Alias not needed, just use the column name
    ]
  end

  def total_entries
    Product.count
  end

  def count
    fetch_records(true).count(:all)
  end
end
