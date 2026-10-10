class AddRestaurantForeignKeyToProducts < ActiveRecord::Migration[8.1]
  def change
    add_foreign_key :products, :restaurants
    add_index :products, :restaurant_id unless index_exists?(:products, :restaurant_id)
  end
end