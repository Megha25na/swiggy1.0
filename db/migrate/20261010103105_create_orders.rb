class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :restru_id
      t.integer :total
      t.string :order_status
      t.string :payment_ref
      t.string :payment_status

      t.timestamps
    end
  end
end
