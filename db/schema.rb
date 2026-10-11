# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_10_11_045717) do
  create_table "items", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "quantity"
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price", default: 0
    t.index ["order_id"], name: "index_items_on_order_id"
    t.index ["product_id"], name: "index_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id"
    t.integer "restru_id"
    t.integer "total"
    t.string "order_status"
    t.string "payment_ref"
    t.string "payment_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "restaurant_id"
    t.string "delivery_address"
    t.string "contact_phone"
    t.string "customer_name"
    t.integer "subtotal", default: 0
    t.integer "delivery_fee", default: 40
    t.integer "tax", default: 0
    t.integer "discount", default: 0
    t.text "notes"
    t.string "payment_method", default: "Cash on Delivery"
    t.index ["restaurant_id"], name: "index_orders_on_restaurant_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "price"
    t.boolean "is_veg"
    t.integer "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category", default: "Main Course"
    t.string "image_url"
    t.boolean "available", default: true
    t.index ["restaurant_id"], name: "index_products_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "cuisine"
    t.decimal "rating", precision: 2, scale: 1, default: "4.2"
    t.string "delivery_time", default: "25-35 mins"
    t.integer "price_for_two", default: 350
    t.string "address"
    t.string "city", default: "Pune"
    t.string "image_url"
    t.boolean "featured", default: false
    t.boolean "pure_veg", default: false
    t.string "phone"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
    t.string "role", default: "customer"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "items", "orders"
  add_foreign_key "items", "products"
  add_foreign_key "products", "restaurants"
end
