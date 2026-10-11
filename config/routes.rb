Rails.application.routes.draw do
  devise_for :users

  # Public discovery & catalog
  root "home#index"
  get "search", to: "home#search", as: :search
  get "offers", to: "home#offers", as: :offers

  resources :restaurants, only: [:index, :show]
  resources :products, only: [:index, :show]

  # Cart system
  resource :cart, only: [:show] do
    post :add_item, on: :member
    patch :update_quantity, on: :member
    delete :remove_item, on: :member
    delete :clear, on: :member
  end

  # Checkout flow
  get "checkout", to: "checkouts#new", as: :checkout
  post "checkout", to: "checkouts#create"

  # Customer orders & tracking
  resources :orders, only: [:index, :show] do
    post :reorder, on: :member
  end

  # Customer profile
  resource :profile, only: [:show, :edit, :update]

  # Administrative console
  namespace :admin do
    root to: "dashboard#index"
    resources :restaurants
    resources :products
    resources :orders, only: [:index, :show, :update]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end

