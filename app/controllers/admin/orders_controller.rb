module Admin
  class OrdersController < BaseController
    before_action :set_order, only: %i[ show update ]

    def index
      @orders = Order.recent.includes(:restaurant, :user)

      if params[:status].present?
        @orders = @orders.where(order_status: params[:status])
      end
    end

    def show
    end

    def update
      if Order::STATUSES.include?(params[:order_status])
        @order.update(order_status: params[:order_status])
        redirect_back fallback_location: admin_orders_path, notice: "Order ##{@order.id} status updated to '#{params[:order_status].titleize}'."
      else
        redirect_back fallback_location: admin_orders_path, alert: "Invalid status."
      end
    end

    private

    def set_order
      @order = Order.find(params[:id])
    end
  end
end
