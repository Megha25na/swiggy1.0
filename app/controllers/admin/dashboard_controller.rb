module Admin
  class DashboardController < BaseController
    def index
      @total_orders = Order.count
      @total_revenue = Order.sum(:total)
      @total_restaurants = Restaurant.count
      @total_products = Product.count
      @total_users = User.count

      @recent_orders = Order.recent.limit(10).includes(:restaurant, :user)
      @active_orders = Order.where.not(order_status: %w[delivered cancelled]).recent
    end
  end
end
