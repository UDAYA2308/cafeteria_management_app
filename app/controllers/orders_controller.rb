class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.where(delivered_at: nil)
    @your_order = true
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  def your_orders
    @orders = Order.where(user_id: @current_user.id).order(:date)
    @your_order = false
    render "index"
  end

  def report
    @orders = Order.order(:date)
    @totals = OrderItem.group(:order_id).sum(:total)
    @count = Order.count
    @sum = OrderItem.sum(:total)
  end

  # GET /orders/new
  def new
    if Menu.find_by(active: true)
      current_menu_id = Menu.find_by(active: true).id
    end
    @menu_items = MenuItem.where(" menu_id = ?  and stock > 0", current_menu_id)
  end

  # GET /orders/1/edit
  def edit
    @status = @order.status == "preparing"
  end

  def view
    redirect_to carts_path
  end

  # POST /orders
  # POST /orders.json
  def create
    items = Cart.where(user_id: @current_user.id)
    if items.count != 0
      new_order = Order.create!(
        user_id: @current_user.id,
        date: Time.now.getutc,
        delivered_at: nil,
        status: "confirm",
      )
    end

    items.each do |item|
      menu_item = MenuItem.find(item.menu_item_id)
      menu_item.stock = menu_item.stock - item.quantity
      menu_item.save

      OrderItem.create!(
        order_id: new_order.id,
        menu_item_id: item.menu_item.id,
        menu_item_name: item.menu_item.menu_item_name,
        menu_item_price: item.menu_item.menu_item_price,
        quantity: item.quantity,
        total: item.quantity * item.menu_item.menu_item_price,
      )
    end
    items.destroy_all
    redirect_to yourorder_path
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    @order.update(status: params[:status])
    @order.save

    if params[:status] == "delivered"
      @order.update(delivered_at: Time.now.utc)
      @order.save
    end

    redirect_to orders_path(notice: "Order Status Updated Successfully ")
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
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
    params.require(:order).permit(:user_id, :date, :delivered_at, :status)
  end
end
