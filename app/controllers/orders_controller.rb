#/workspaces/Inventory-Management-System/app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  respond_to :html, :datatables

  # GET /orders or /orders.json
  def index
    @pagy, @orders = pagy(Order.all)
    # @pagy, @incoming_orders = pagy(Order.incoming)
    # @pagy, @outgoing_orders = pagy(Order.outgoing)
    authorize @orders
  end

  # GET /orders/incoming
  def incoming
    @pagy, @incoming_orders = pagy(Order.incoming)
    authorize @incoming_orders
  end

  # GET /orders/outgoing
  def outgoing
    @pagy, @outgoing_orders = pagy(Order.outgoing)
    authorize @outgoing_orders
  end

  # GET /orders/1 or /orders/1.json
  def show
    @order = Order.find(params[:id])
    @incoming_orders = Order.incoming
    @outgoing_orders = Order.outgoing
    authorize @order
    @pagy, @products = pagy(Product.all)
  end

  # GET /orders/new
  def new
    @order = Order.new
    authorize @order
    @pagy, @products = pagy(Product.all)
  end

  def edit
    @order = Order.find(params[:id]) # Retrieve the order by its ID
    authorize @order
    @pagy, @products = pagy(Product.all)
  end

  # POST /orders or /orders.json
  # POST /orders or /orders.json
  def create
    puts "Order params: #{order_params.inspect}"
    @order = Order.new(order_params)
    authorize @order
    @pagy, @products = pagy(Product.all)

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
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
    @order = Order.find(params[:id])
    authorize @order

    # Process the order_params to remove empty strings from the products array
    processed_order_params = order_params
    if processed_order_params[:products].present?
      processed_order_params[:products]&.reject!(&:blank?)
    end

    respond_to do |format|
      if @order.update(processed_order_params)
        # Debugging line 1: Print the processed order_params to the console
        puts "Processed order_params: #{processed_order_params.inspect}"

        # Additional logic to associate products with the order
        if processed_order_params[:products].present?
          product_ids = processed_order_params[:products].reject(&:empty?).map(&:to_i)
          @order.product_ids = product_ids

          if products.count == product_ids.count
            # Debugging line 2: Print the list of product_ids and their count
            puts "Product IDs: #{product_ids.inspect}, Count: #{product_ids.count}"

            # All products exist, associate them with the order
            @order.products = products
            @order.save
            format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
            format.json { render :show, status: :ok, location: @order }
          else
            # Handle the case where some products don't exist
            format.html { render :edit, status: :unprocessable_entity, notice: "Some selected products do not exist." }
            format.json { render json: { error: "Some selected products do not exist." }, status: :unprocessable_entity }
          end
        else
          # No products selected, do nothing
          format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
          format.json { render :show, status: :ok, location: @order }
        end
      else
        # Debugging line 3: Print the errors if the order update fails
        puts "Order update failed. Errors: #{order.errors.full_messages}"

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
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
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
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
      order_products_attributes: [:id, :quantity_ordered, :shipping_cost, :product_id],
    )
  end
end
