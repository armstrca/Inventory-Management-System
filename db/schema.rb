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

ActiveRecord::Schema[7.0].define(version: 2023_10_17_202755) do
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "subcategory"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventory_transactions", force: :cascade do |t|
    t.string "transaction_type"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "quantity_ordered_id", null: false
    t.integer "unit_price_id", null: false
    t.integer "shipping_cost_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quantity_ordered_id"], name: "index_order_items_on_quantity_ordered_id"
    t.index ["shipping_cost_id"], name: "index_order_items_on_shipping_cost_id"
    t.index ["unit_price_id"], name: "index_order_items_on_unit_price_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "expected_delivery"
    t.string "status"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "sku"
    t.decimal "price"
    t.integer "stock_quantity"
    t.integer "category_id_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id_id"], name: "index_products_on_category_id_id"
  end

  create_table "reports", force: :cascade do |t|
    t.string "report_type"
    t.datetime "date"
    t.string "data_criteria"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.integer "admin_id", null: false
    t.integer "staff_id", null: false
    t.integer "manager_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_roles_on_admin_id"
    t.index ["manager_id"], name: "index_roles_on_manager_id"
    t.index ["staff_id"], name: "index_roles_on_staff_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.string "contact_info"
    t.string "description"
    t.string "standing"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "image"
    t.string "role"
    t.string "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "views", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_views_on_email", unique: true
    t.index ["reset_password_token"], name: "index_views_on_reset_password_token", unique: true
  end

  add_foreign_key "order_items", "quantity_ordereds"
  add_foreign_key "order_items", "shipping_costs"
  add_foreign_key "order_items", "unit_prices"
  add_foreign_key "products", "category_ids"
  add_foreign_key "roles", "admins"
  add_foreign_key "roles", "managers"
  add_foreign_key "roles", "staffs"
end
