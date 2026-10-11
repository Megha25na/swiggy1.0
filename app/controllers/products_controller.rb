class ProductsController < ApplicationController
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :require_admin!, except: %i[ index show ]
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @products = Product.available.includes(:restaurant)

    if params[:q].present?
      @products = @products.search_by_keyword(params[:q])
    end

    if params[:veg_only] == "true"
      @products = @products.veg
    end

    if params[:category].present?
      @products = @products.where(category: params[:category])
    end

    @categories = Product.available.pluck(:category).compact.uniq.sort
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Dish was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @product.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Dish was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @product.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_path, notice: "Dish was successfully removed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :is_veg, :restaurant_id, :category, :image_url, :available)
  end
end

