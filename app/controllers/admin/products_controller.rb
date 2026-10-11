module Admin
  class ProductsController < BaseController
    before_action :set_product, only: %i[ show edit update destroy ]

    def index
      @products = Product.includes(:restaurant).order(created_at: :desc)
    end

    def show
    end

    def new

      @product = Product.new
      @restaurants = Restaurant.all
    end

    def edit
      @restaurants = Restaurant.all
    end

    def create
      @product = Product.new(product_params)
      @restaurants = Restaurant.all

      if @product.save
        redirect_to admin_products_path, notice: "Dish '#{@product.name}' was created successfully."
      else
        render :new, status: :unprocessable_content
      end
    end

    def update
      @restaurants = Restaurant.all
      if @product.update(product_params)
        redirect_to admin_products_path, notice: "Dish '#{@product.name}' was updated successfully."
      else
        render :edit, status: :unprocessable_content
      end
    end

    def destroy
      @product.destroy!
      redirect_to admin_products_path, notice: "Dish was removed successfully."
    end

    private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(
        :name, :description, :price, :is_veg, :restaurant_id, 
        :category, :image_url, :available
      )
    end
  end
end
