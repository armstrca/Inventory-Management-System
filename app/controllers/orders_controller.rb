#/workspaces/Inventory-Management-System/app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/incoming
  def incoming
    @incoming_orders = Order.incoming
  end

  # GET /orders/outgoing
  def outgoing
    @outgoing_orders = Order.outgoing
  end

  # GET /orders/1 or /orders/1.json
  def show
    @order = Order.find(params[:id])
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  def edit
    @order = Order.find(params[:id]) # Retrieve the order by its ID
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update(order_params)
        # Additional logic to associate products with the order
        if order_params[:product].present?
          product_ids = order_params[:product].map(&:to_i)
          products = Product.where(id: product_ids)

          if products.count == product_ids.count
            # All products exist, associate them with the order
            @order.products = products
            format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
            format.json { render :show, status: :ok, location: @order }
          else
            # Handle the case where some products don't exist
            @order.products.clear
            format.html { render :edit, status: :unprocessable_entity, notice: "Some selected products do not exist." }
            format.json { render json: { error: "Some selected products do not exist." }, status: :unprocessable_entity }
          end
        else
          @order.products.clear # Remove all products if none are selected
          format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
          format.json { render :show, status: :ok, location: @order }
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy

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
      products: [],
    )
  end
end
