class EnhanceTablesForFoodDelivery < ActiveRecord::Migration[8.1]
  def change
    # Enhance users
    add_column :users, :phone, :string
    add_column :users, :role, :string, default: "customer"

    # Enhance restaurants
    add_column :restaurants, :description, :text
    add_column :restaurants, :cuisine, :string
    add_column :restaurants, :rating, :decimal, precision: 2, scale: 1, default: 4.2
    add_column :restaurants, :delivery_time, :string, default: "25-35 mins"
    add_column :restaurants, :price_for_two, :integer, default: 350
    add_column :restaurants, :address, :string
    add_column :restaurants, :city, :string, default: "Pune"
    add_column :restaurants, :image_url, :string
    add_column :restaurants, :featured, :boolean, default: false
    add_column :restaurants, :pure_veg, :boolean, default: false
    add_column :restaurants, :phone, :string

    # Enhance products
    add_column :products, :category, :string, default: "Main Course"
    add_column :products, :image_url, :string
    add_column :products, :available, :boolean, default: true

    # Enhance orders
    add_column :orders, :restaurant_id, :integer
    add_column :orders, :delivery_address, :string
    add_column :orders, :contact_phone, :string
    add_column :orders, :customer_name, :string
    add_column :orders, :subtotal, :integer, default: 0
    add_column :orders, :delivery_fee, :integer, default: 40
    add_column :orders, :tax, :integer, default: 0
    add_column :orders, :discount, :integer, default: 0
    add_column :orders, :notes, :text
    add_column :orders, :payment_method, :string, default: "Cash on Delivery"
    add_index :orders, :restaurant_id
    add_index :orders, :user_id

    # Enhance items
    add_column :items, :price, :integer, default: 0
  end
end

