class RestaurantsController < ApplicationController
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :require_admin!, except: %i[ index show ]
  before_action :set_restaurant, only: %i[ show edit update destroy ]

  # GET /restaurants or /restaurants.json
  def index
    @restaurants = Restaurant.all

    # Keyword search
    if params[:q].present?
      @restaurants = @restaurants.search_by_keyword(params[:q])
    end

    # Cuisine filter
    if params[:cuisine].present?
      @restaurants = @restaurants.where("LOWER(cuisine) LIKE ?", "%#{params[:cuisine].downcase}%")
    end

    # Pure veg filter
    if params[:pure_veg] == "true" || params[:pure_veg] == "1"
      @restaurants = @restaurants.pure_veg
    end

    # Sorting
    case params[:sort]
    when "rating"
      @restaurants = @restaurants.order(rating: :desc)
    when "price_asc"
      @restaurants = @restaurants.order(price_for_two: :asc)
    when "price_desc"
      @restaurants = @restaurants.order(price_for_two: :desc)
    when "delivery_time"
      @restaurants = @restaurants.order(:delivery_time)
    else
      @restaurants = @restaurants.order(rating: :desc)
    end

    @all_cuisines = Restaurant.pluck(:cuisine).compact.flat_map { |c| c.split(",").map(&:strip) }.uniq.sort
  end

  # GET /restaurants/1 or /restaurants/1.json
  def show
    @products = @restaurant.products.available
    if params[:veg_only] == "true"
      @products = @products.veg
    end

    if params[:search].present?
      @products = @products.search_by_keyword(params[:search])
    end

    @products_by_category = @products.group_by { |p| p.category.presence || "Popular Dishes" }
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants or /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: "Restaurant was successfully created." }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @restaurant.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /restaurants/1 or /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: "Restaurant was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @restaurant.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /restaurants/1 or /restaurants/1.json
  def destroy
    @restaurant.destroy!

    respond_to do |format|
      format.html { redirect_to restaurants_path, notice: "Restaurant was successfully deleted.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :cuisine, :rating, :delivery_time, :price_for_two, :address, :city, :image_url, :featured, :pure_veg, :phone)
  end
end

