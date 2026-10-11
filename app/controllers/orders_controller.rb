class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: %i[ show reorder ]

  # GET /orders
  def index
    @orders = current_user.orders.recent.includes(:restaurant, items: :product)
  end

  # GET /orders/1
  def show
    unless @order.user_id == current_user.id || current_user.admin?
      redirect_to orders_path, alert: "You are not authorized to view this order."
    end
  end

  # POST /orders/1/reorder
  def reorder
    cart.clear
    @order.items.each do |item|
      cart.add_item(item.product_id, item.quantity)
    end

    redirect_to cart_path, notice: "Items from order ##{@order.id} added to your cart!"
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
