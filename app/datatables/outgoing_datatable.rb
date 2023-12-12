#/workspaces/Inventory-Management-System/app/datatables/outgoing_datatable.rb
# /workspaces/Inventory-Management-System/app/datatables/order_datatable.rb
require "application_datatable"

class OutgoingDatatable < ApplicationDatatable
  delegate :params, to: :@view
  include Kaminari::PageScopeMethods

  def as_json(options = {})
    {
      recordsTotal: count,
      recordsFiltered: total_entries,
      data: data,
    }
  end

  private

  def data
    records.map do |order|
      {
        id: order.id,
        expected_delivery: order.expected_delivery,
        status: order.status.gsub('_', ' ').titleize,
        description: order.description,
        product_id: order.products.pluck(:id).join(", "),
        quantity_ordered: order.order_products.sum(:quantity_ordered),
        shipping_cost: order.order_products.sum(:shipping_cost),
        order_total: order.total,
        receiving_address: order.receiving_address,
        sending_address: order.sending_address,
        branch_id: order.branch_id,
        company_id: order.company_id,
      }
    end
  end

  def records
    @records ||= fetch_records
  end

  def fetch_records
    orders = Order.outgoing.joins(:order_products).group('orders.id')
    if params[:order].present?
      orders = orders.order(Arel.sql("#{sort_column} #{sort_direction}"))
    end
    orders = orders.page(page).per(per_page)
    if params[:search][:value].present?
      search_value = "%#{params[:search][:value]}%"
      orders = orders.where(search_query, search_value: search_value)
    end
    orders
  end

  def search_query
    # Construct a SQL query for searching multiple columns
    # Exclude 'product_id' from the search columns if it's not a direct column
    queries = searchable_columns.reject { |col| col == :product_id || col == :quantity_ordered || col == :shipping_cost }.map { |column|
      "#{column} LIKE :search_value"
    }

    # If you want to search by product_id, consider adding a join and a condition like:
    queries << "order_product.product_id LIKE :search_value"
    queries << "order_products.quantity_ordered LIKE :search_value"
    queries << "order_products.shipping_cost LIKE :search_value"

    queries.join(' OR ')
  end

  def sort_column
    # Define a whitelist of column names
      # Temporarily hardcode the column name for testing
  return 'orders.total' if params[:order]['0'][:column].to_i == 9
    columns = %w[
      orders.id
      orders.expected_delivery
      orders.status
      orders.sending_address
      orders.receiving_address
      orders.description
      orders.total
      quantity_ordered
      shipping_cost
    ]

    # Use a hash to map the sortable columns to their corresponding SQL expressions
    column_expressions = {
      'quantity_ordered' => 'SUM(order_products.quantity_ordered)',
      'shipping_cost' => 'SUM(order_products.shipping_cost)'
    }

    index = params[:order]['0'][:column].to_i
    column_name = columns[index]

    # Use the SQL expression if it exists, otherwise use the column name directly
    column_expressions.fetch(column_name, column_name)
  end

  def sort_direction
    # Define a whitelist of valid sort directions
    %w[asc desc].include?(params[:order]['0'][:dir]) ? params[:order]['0'][:dir] : 'asc'
  end

  def page
    params[:start].to_i / per_page + 1
  end

  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  def searchable_columns
    @searchable_columns ||= [
      :id,
      :expected_delivery,
      :status,
      :sending_address,
      :receiving_address,
      :description,
      :product_id,
      :order_total,
      :quantity_ordered,
      :shipping_cost,
    ]
  end

  def order_columns
    @order_columns ||= [
      :id,
      :expected_delivery,
      :status,
      :sending_address,
      :receiving_address,
      :description,
      :product_id,
      :order_total,
      :quantity_ordered,
      :shipping_cost,
    ]
  end

  def total_entries
    Order.outgoing.count
  end

  def count
    Order.outgoing.count
  end
end
