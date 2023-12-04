# /workspaces/Inventory-Management-System/app/datatables/order_datatable.rb
require "application_datatable"

class OrderDatatable < ApplicationDatatable
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
    records.map do |order|
      {
        id: order.id,
        expected_delivery: order.expected_delivery,
        status: order.status,
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
    orders = Order.order("#{sort_column} #{sort_direction}")
    orders = orders.page(page).per(per_page)
    if params[:search][:value].present?
      orders = orders.where("status LIKE ?", "%#{params[:search][:value]}%")
    end
    orders
  end

  def sort_column
    columns = %w[id expected_delivery status description receiving_address sending_address total]
    columns[params[:order]["0"][:column].to_i]
  end

  def sort_direction
    params[:order]["0"][:dir] == "desc" ? "desc" : "asc"
  end

  def page
    params[:start].to_i / per_page + 1
  end

  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  def searchable_columns
    # Define the columns that are searchable in the DataTable
    @searchable_columns ||= [
      :id,
      :expected_delivery,
      :status,
      :sending_address,
      :receiving_address,
      :description,
      :product_name,
      :quantity_ordered,
      :quantity_ordered,
      :shipping_cost,
      :order_total,
    # ... add other searchable columns
    ]
  end

  def order_columns
    # Define the columns that are sortable in the DataTable
    @order_columns ||= [
      :id,
      :expected_delivery,
      :status,
      :sending_address,
      :receiving_address,
      :description,
      :product_name,
      :quantity_ordered,
      :quantity_ordered,
      :shipping_cost,
      :order_total,
    # ... add other orderable columns
    ]
  end

  def total_entries
    Order.count # or any other way you count your total entries
  end

  def count
    Order.count # or any other way you count your total entries
  end
end
