# app/datatables/new_order_datatable.rb

class NewOrderProductDatatable < ApplicationDatatable
  delegate :params, :link_to, :number_to_currency, to: :@view

  def as_json(options = {})
    {
      recordsTotal: count,
      recordsFiltered: total_entries,
      data: data,
    }
  end

  private



  def data
    # If we are editing an existing order, pre-fetch its order_products
    existing_order_products = params[:orderId].present? ? Order.find(params[:orderId]).order_products.index_by(&:product_id) : {}

    records.map do |product|
      # Check if the product is part of the existing order
      order_product = existing_order_products[product.id]
      in_order = order_product.present?

      {
        id: product.id,
        name: product.name,
        sku: product.sku,
        price: number_to_currency(product.price),
        stock_quantity: product.stock_quantity,
        supplier: product.supplier_name,
        checkbox: in_order ? 'checked' : '',
        quantity_ordered: in_order ? order_product.quantity_ordered : nil,
        shipping_cost: in_order ? order_product.shipping_cost : nil,
        transaction_type: in_order ? order_product.transaction_type : nil,
        disabled: in_order ? 'disabled' : ''
      }
    end
  end

  def records
    @records ||= fetch_records
  end

  def fetch_records(counting = false)
    # For counting, simply count products without the join which is unnecessary
    return Product.all if counting

    # For fetching records to display, join with the supplier table and select the supplier_name alias
    isNewOrder = params[:isNewOrder]
    orderId = params[:orderId]

    products = Product.joins(:supplier).select('products.*, suppliers.name AS supplier_name')

    if isNewOrder == "false" && orderId.present?
      order = Order.find(orderId)
      order_product_ids = order.order_products.pluck(:product_id)

      # Conditional sorting logic based on whether the product is part of the order
      ordered_products = Product.where(id: order_product_ids)
      other_products = Product.where.not(id: order_product_ids)

      # Combine the above queries
      products = Product.from("(#{ordered_products.to_sql} UNION #{other_products.to_sql}) AS products")
                        .joins(:supplier)
                        .select('products.*, suppliers.name AS supplier_name')
    end

    unless counting
      # Apply additional sorting if necessary
      if params[:order].present?
        products = products.order(sort_column => sort_direction)
      end

      products = products.page(page).per(per_page)

      if params[:search][:value].present?
        search_value = "%#{params[:search][:value]}%"
        products = products.where(search_query, search_value: search_value)
      end
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
      products.supplier_name
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
    ]
  end

  def total_entries
    Product.count
  end

  def count
    fetch_records(true).count(:all)
  end

end
