module Admin
  class RestaurantsController < BaseController
    before_action :set_restaurant, only: %i[ show edit update destroy ]

    def index
      @restaurants = Restaurant.all.order(created_at: :desc)
    end

    def show
      @products = @restaurant.products
    end

    def new
      @restaurant = Restaurant.new
    end

    def edit
    end

    def create
      @restaurant = Restaurant.new(restaurant_params)

      if @restaurant.save
        redirect_to admin_restaurants_path, notice: "Restaurant '#{@restaurant.name}' was created successfully."
      else
        render :new, status: :unprocessable_content
      end
    end

    def update
      if @restaurant.update(restaurant_params)
        redirect_to admin_restaurants_path, notice: "Restaurant '#{@restaurant.name}' was updated successfully."
      else
        render :edit, status: :unprocessable_content
      end
    end

    def destroy
      @restaurant.destroy!
      redirect_to admin_restaurants_path, notice: "Restaurant was deleted successfully."
    end

    private

    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    def restaurant_params
      params.require(:restaurant).permit(
        :name, :description, :cuisine, :rating, :delivery_time, 
        :price_for_two, :address, :city, :image_url, :featured, :pure_veg, :phone
      )
    end
  end
end
