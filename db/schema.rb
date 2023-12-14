# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 21) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string("name", null: false)
    t.string("record_type", null: false)
    t.bigint("record_id", null: false)
    t.bigint("blob_id", null: false)
    t.datetime("created_at", null: false)
    t.index(["blob_id"], name: "index_active_storage_attachments_on_blob_id")
    t.index(
      ["record_type", "record_id", "name", "blob_id"],
      name: "index_active_storage_attachments_uniqueness",
      unique: true,
    )
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string("key", null: false)
    t.string("filename", null: false)
    t.string("content_type")
    t.text("metadata")
    t.string("service_name", null: false)
    t.bigint("byte_size", null: false)
    t.string("checksum")
    t.datetime("created_at", null: false)
    t.index(["key"], name: "index_active_storage_blobs_on_key", unique: true)
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint("blob_id", null: false)
    t.string("variation_digest", null: false)
    t.index(["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true)
  end

  create_table "branches", force: :cascade do |t|
    t.string("name")
    t.integer("company_id")
    t.string("address")
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.index(["company_id"], name: "index_branches_on_company_id")
  end

  create_table "categories", force: :cascade do |t|
    t.string("name")
    t.string("description")
    t.string("subcategory")
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.integer("company_id")
    t.index(["company_id"], name: "index_categories_on_company_id")
  end

  create_table "companies", force: :cascade do |t|
    t.string("name")
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
  end

  create_table "order_products", force: :cascade do |t|
    t.integer("quantity_ordered")
    t.float("shipping_cost")
    t.string("transaction_type")
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.integer("product_id", null: false)
    t.integer("order_id", null: false)
    t.index(["order_id"], name: "index_order_products_on_order_id")
    t.index(["product_id"], name: "index_order_products_on_product_id")
  end

  create_table "orders", force: :cascade do |t|
    t.date("expected_delivery")
    t.string("status")
    t.string("description")
    t.string("sending_address")
    t.string("receiving_address")
    t.decimal("total")
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.integer("company_id")
    t.integer("branch_id")
    t.index(["branch_id"], name: "index_orders_on_branch_id")
    t.index(["company_id"], name: "index_orders_on_company_id")
    t.index(["expected_delivery"], name: "index_orders_on_expected_delivery")
    t.index(["receiving_address"], name: "index_orders_on_receiving_address")
    t.index(["sending_address"], name: "index_orders_on_sending_address")
  end

  create_table "products", force: :cascade do |t|
    t.string("name")
    t.string("description")
    t.integer("sku")
    t.decimal("price")
    t.integer("stock_quantity")
    t.integer("category_id", null: false)
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.integer("subcategory_id", null: false)
    t.integer("supplier_id")
    t.integer("company_id")
    t.integer("branch_id")
    t.index(["branch_id"], name: "index_products_on_branch_id")
    t.index(["category_id"], name: "index_products_on_category_id")
    t.index(["company_id", "branch_id", "category_id"], name: "index_products_on_company_and_branch_and_category")
    t.index(["company_id"], name: "index_products_on_company_id")
    t.index(["subcategory_id"], name: "index_products_on_subcategory_id")
    t.index(["supplier_id"], name: "index_products_on_supplier_id")
  end

  create_table "reports", force: :cascade do |t|
    t.string("report_type")
    t.datetime("date")
    t.string("data_criteria")
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.integer("company_id")
    t.integer("branch_id")
    t.index(["branch_id"], name: "index_reports_on_branch_id")
    t.index(["company_id"], name: "index_reports_on_company_id")
  end

  create_table "storage_locations", force: :cascade do |t|
    t.string("name")
    t.string("description")
    t.string("address")
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.integer("company_id")
    t.integer("branch_id")
    t.index(["branch_id"], name: "index_storage_locations_on_branch_id")
    t.index(["company_id"], name: "index_storage_locations_on_company_id")
  end

  create_table "subcategories", force: :cascade do |t|
    t.string("name")
    t.text("description")
    t.integer("category_id", null: false)
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.integer("company_id")
    t.index(["category_id"], name: "index_subcategories_on_category_id")
    t.index(["company_id"], name: "index_subcategories_on_company_id")
  end

  create_table "suppliers", force: :cascade do |t|
    t.string("name")
    t.string("contact_info")
    t.string("description")
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.string("address")
    t.integer("company_id")
    t.index(["company_id"], name: "index_suppliers_on_company_id")
  end

  create_table "users", force: :cascade do |t|
    t.string("email", default: "", null: false)
    t.string("encrypted_password", default: "", null: false)
    t.string("reset_password_token")
    t.datetime("reset_password_sent_at")
    t.datetime("remember_created_at")
    t.string("first_name")
    t.string("last_name")
    t.string("image")
    t.string("role")
    t.string("bio")
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.integer("company_id")
    t.integer("branch_id")
    t.index(["branch_id"], name: "index_users_on_branch_id")
    t.index(["company_id"], name: "index_users_on_company_id")
    t.index(["email"], name: "index_users_on_email", unique: true)
    t.index(["reset_password_token"], name: "index_users_on_reset_password_token", unique: true)
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "branches", "companies"
  add_foreign_key "categories", "companies"
  add_foreign_key "order_products", "orders"
  add_foreign_key "order_products", "products"
  add_foreign_key "orders", "branches"
  add_foreign_key "orders", "companies"
  add_foreign_key "products", "branches"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "companies"
  add_foreign_key "products", "subcategories"
  add_foreign_key "products", "suppliers"
  add_foreign_key "reports", "branches"
  add_foreign_key "reports", "companies"
  add_foreign_key "storage_locations", "branches"
  add_foreign_key "storage_locations", "companies"
  add_foreign_key "subcategories", "categories"
  add_foreign_key "subcategories", "companies"
  add_foreign_key "suppliers", "companies"
  add_foreign_key "users", "branches"
  add_foreign_key "users", "companies"
end
