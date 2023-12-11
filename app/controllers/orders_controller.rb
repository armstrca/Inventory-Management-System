#/workspaces/Inventory-Management-System/app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  respond_to :html, :datatables

  # GET /orders or /orders.json

  def index
    @orders = Order.all
    authorize @orders
    respond_to do |format|
      format.html
      format.json { render json: OrderDatatable.new(view_context).as_json }
    end
  end


  def incoming
    @incoming_orders = Order.incoming
    authorize @incoming_orders
    respond_to do |format|
      format.html
      format.json { render json: IncomingDatatable.new(view_context).as_json }
    end
  end

  def outgoing
    @outgoing_orders = Order.outgoing
    authorize @outgoing_orders
    respond_to do |format|
      format.html
      format.json { render json: OutgoingDatatable.new(view_context).as_json }
    end
  end

  # GET /orders/1 or /orders/1.json
  def show
    @order = Order.find(params[:id])
    @incoming_orders = Order.incoming
    @outgoing_orders = Order.outgoing
    authorize @order
    @products = Product.all
  end

  # GET /orders/new
  def new
    @order = Order.new
    selected_products_count = params[:selected_products_count].to_i
    selected_products_count.times { @order.order_products.build }
    authorize @order
    @products = Product.all
    respond_to do |format|
      format.html
      format.json { render json: NewOrderProductDatatable.new(view_context).as_json }
    end
  end

  def edit
    @order = Order.find(params[:id])
    @order.order_products.build if @order.order_products.empty? # Build a new OrderProduct if none exist
    authorize @order
    @products = Product.all
  end

  # POST /orders or /orders.json
  def create
    puts "Order params: #{order_params.inspect}"
    @order = Order.new(order_params)
    order_product_attributes = order_params[:order_products_attributes]
    selected_product_ids = order_product_attributes.values.map { |product| product[:product_id] } if order_product_attributes.present?

    authorize @order
    @products = Product.all

    respond_to do |format|
      if @order.save
        @order.calculate_total
        StockUpdateService.new(@order).update_stock! # Call the service to update stock
        @order.save
        format.html { redirect_to order_url(@order), notice: "Order successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        # Debugging line: Print the errors if the order save fails
        puts "Order save failed. Errors: #{@order.errors.full_messages}"

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    @order = Order.includes(order_products: :product).find(params[:id])
    @order.order_products.build if @order.order_products.empty?

    authorize @order
    # Process the order_params to remove empty strings from the products array
    processed_order_params = order_params

    respond_to do |format|
      ActiveRecord::Base.transaction do
        if processed_order_params[:order_products_attributes].present? && @order.update!(processed_order_params)
          # Additional logic to update existing order products
          existing_order_product_ids = @order.order_products.pluck(:product_id)
          @order.calculate_total
          StockUpdateService.new(@order).update_stock!

          if processed_order_params[:order_products_attributes].present?
            submitted_order_products = processed_order_params[:order_products_attributes].values

            submitted_order_products.each do |submitted_product|
              product_id = submitted_product[:product_id].to_i
              existing_order_product = @order.order_products.find_by(product_id: product_id)

              if existing_order_product.present?
                # Use existing values unless explicitly altered
                existing_order_product.update(
                  quantity_ordered: submitted_product[:quantity_ordered].presence || existing_order_product.quantity_ordered,
                  shipping_cost: submitted_product[:shipping_cost].presence || existing_order_product.shipping_cost,
                  transaction_type: submitted_product[:transaction_type].presence || existing_order_product.transaction_type,
                )

                # Update stock_quantity for the associated product
                product = existing_order_product.product
                new_stock_quantity = product.stock_quantity - existing_order_product.quantity_ordered.to_i
                product.update(stock_quantity: new_stock_quantity)
              else
                # If the product_id doesn't exist in the order, create a new order_product
                @order.order_products.create(
                  product_id: product_id,
                  quantity_ordered: submitted_product[:quantity_ordered],
                  shipping_cost: submitted_product[:shipping_cost],
                  transaction_type: submitted_product[:transaction_type],
                )
                @order.calculate_total
                StockUpdateService.new(@order).update_stock!
              end
            end
          end

          format.html { redirect_to order_url(@order), notice: "Order successfully updated." }
          format.json { render :show, status: :ok, location: @order }
        else
          # Debugging line: Print the errors if the order update fails
          puts "Order update failed. Errors: #{@order.errors.full_messages}"

          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy
    authorize @order
    @order.order_products.each do |product|
      product.update(category: nil)
    end
    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # DELETE /orders/1/remove_product/2
  def remove_product
    @order = Order.find(params[:id])
    product_id = params[:product_id]
    authorize @order

    # Ensure the product is associated with the order
    order_product = @order.order_products.find_by(product_id: product_id)

    if order_product
      # Update stock_quantity for the associated product before destroying the order_product
      product = order_product.product
      new_stock_quantity = product.stock_quantity + order_product.quantity_ordered.to_i
      product.update(stock_quantity: new_stock_quantity)

      order_product.destroy

      respond_to do |format|
        format.html { redirect_to order_url(@order), notice: "Product successfully removed from the order." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to edit_order_url(@order), alert: "Product not found in the order." }
        format.json { render json: { error: "Product not found in the order." }, status: :not_found }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(
      :expected_delivery,
      :status,
      :description,
      :receiving_address,
      :sending_address,
      :company_id,
      :branch_id,
      :total,
      order_products_attributes: [:id, :quantity_ordered, :shipping_cost, :product_id, :transaction_type],
    )
  end
end
