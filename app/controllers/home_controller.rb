class HomeController < ApplicationController
  def index
    @categories = [
      { name: "Biryani", image: "https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=200&q=80" },
      { name: "Pizza", image: "https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=200&q=80" },
      { name: "Burgers", image: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=200&q=80" },
      { name: "North Indian", image: "https://images.unsplash.com/photo-1585937421612-70a008356fbe?auto=format&fit=crop&w=200&q=80" },
      { name: "Chinese", image: "https://images.unsplash.com/photo-1569718212165-3a8278d5f624?auto=format&fit=crop&w=200&q=80" },
      { name: "Rolls", image: "https://images.unsplash.com/photo-1626777552726-4a6b54c97e46?auto=format&fit=crop&w=200&q=80" },
      { name: "Desserts", image: "https://images.unsplash.com/photo-1551024709-8f23befc6f87?auto=format&fit=crop&w=200&q=80" },
      { name: "South Indian", image: "https://images.unsplash.com/photo-1610057099443-fde8c4d50f91?auto=format&fit=crop&w=200&q=80" }
    ]

    @featured_restaurants = Restaurant.featured.limit(4)
    @top_restaurants = Restaurant.order(rating: :desc).limit(8)
    @all_restaurants = Restaurant.all

    # Filter on homepage if filter param present
    if params[:filter] == "pure_veg"
      @all_restaurants = @all_restaurants.pure_veg
    elsif params[:filter] == "fast_delivery"
      @all_restaurants = @all_restaurants.where("delivery_time LIKE ?", "%20%")
    elsif params[:filter] == "top_rated"
      @all_restaurants = @all_restaurants.where("rating >= ?", 4.3)
    end

    @trending_dishes = Product.available.limit(6)
  end

  def search
    @query = params[:q].to_s.strip
    if @query.present?
      @restaurants = Restaurant.search_by_keyword(@query)
      @products = Product.available.search_by_keyword(@query).includes(:restaurant)
    else
      @restaurants = Restaurant.none
      @products = Product.none
    end
  end

  def offers
    @restaurants = Restaurant.all.limit(9)
    @promo_codes = [
      { code: "SWIGY50", discount: "50% OFF up to ₹100", min_order: "Above ₹199", bg: "#FC8019" },
      { code: "FEAST120", discount: "Flat ₹120 OFF", min_order: "Above ₹399", bg: "#60B246" },
      { code: "FREEDEL", discount: "FREE Delivery", min_order: "Above ₹149", bg: "#2B39B9" },
      { code: "TRYNEW", discount: "60% OFF on First Order", min_order: "No min order", bg: "#E43B4F" }
    ]
  end
end
