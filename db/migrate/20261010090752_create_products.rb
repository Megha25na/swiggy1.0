class CreateProducts < ActiveRecord::Migration[8.1]
  def up
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.boolean :is_veg
      t.integer :restaurant_id

      t.timestamps
    end
  end
end
