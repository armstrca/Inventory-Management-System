# app/services/stock_update_service.rb
class StockUpdateService
  def initialize(order)
    @order = order
  end

  def update_stock!
    ActiveRecord::Base.transaction do
      @order.order_products.each do |order_product|
        update_product_stock(order_product)
      end
    end
  end

  private

  def update_product_stock(order_product)
    product = order_product.product
    case order_product.transaction_type
    when 'purchase_from_supplier', 'refund_to_customer'
      new_quantity = product.stock_quantity + order_product.quantity_ordered
    when 'sale_to_customer', 'return_to_supplier', 'stock_loss'
      new_quantity = product.stock_quantity - order_product.quantity_ordered
    else
      # You may want to handle other transaction types or raise an error
      return
    end

    product.update!(stock_quantity: new_quantity)
  end
end
