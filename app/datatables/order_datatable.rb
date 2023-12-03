#/workspaces/Inventory-Management-System/app/datatables/order_datatable.rb
class OrderDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: "Order.id", cond: :eq },
      delivery_eda: { source: "Order.expected_delivery", cond: :like, searchable: true, orderable: true },
      status: { source: "Order.status", cond: :like, searchable: true, orderable: true },
      receiving_address: { source: "Order.receiving_address", cond: :like, searchable: true, orderable: true },
      sending_address: { source: "Order.sending_address", cond: :like, searchable: true, orderable: true },
      tracking: { source: "Order.description", cond: :like, searchable: true, orderable: true },
      product_id: { source: "Order.products.pluck(:id).join(', ')", cond: :eq, searchable: true, orderable: true },
      units: { source: "order.order_products.sum(:quantity_ordered)", cond: :eq },
      shipping_cost: { source: "number_with_precision(order.order_products.sum(:shipping_cost), precision: 2)", cond: :eq, searchable: true, orderable: true },

    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        expected_delivery: record.expected_delivery,
        status: record.status,
        receiving_address: record.receiving_address,
        sending_address: record.sending_address,
        description: record.description,
        product_id: record.products.pluck(:id).join(', '),
        units: record.order_products.sum(:quantity_ordered),
        shipping_cost: record.order_products.sum(:shipping_cost)
      }
    end
  end

  def get_raw_records
    Order.all
  end
end
