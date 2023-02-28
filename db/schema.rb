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

ActiveRecord::Schema[7.0].define(version: 2023_02_21_104123) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "billing_address"
    t.string "shipping_address"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "zipcode"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "banner_managements", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blogs", force: :cascade do |t|
    t.string "title"
    t.string "post"
    t.string "author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "created_by"
    t.date "created_date"
    t.integer "modify_by"
    t.date "modify_date"
    t.integer "status", default: 0
    t.bigint "parent_id"
    t.index ["parent_id"], name: "index_categories_on_parent_id"
  end

  create_table "configurations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "conf_key"
    t.string "conf_value"
    t.integer "created_by"
    t.date "created_date"
    t.integer "modify_by"
    t.date "modify_date"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "contact_no"
    t.string "message"
    t.text "note_admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "content_management_systems", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.string "meta_title"
    t.string "meta_description"
    t.string "meta_keywords"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "modify_date"
    t.integer "modify_by"
    t.string "code"
    t.decimal "percent_off", precision: 15, scale: 6
    t.integer "number_of_uses"
    t.boolean "status"
  end

  create_table "coupons_useds", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "coupon_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "final_amount"
    t.index ["coupon_id"], name: "index_coupons_useds_on_coupon_id"
    t.index ["user_id"], name: "index_coupons_useds_on_user_id"
  end

  create_table "order_details", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity"
    t.decimal "amount"
    t.bigint "product_id", null: false
    t.bigint "order_id", null: false
    t.index ["order_id"], name: "index_order_details_on_order_id"
    t.index ["product_id"], name: "index_order_details_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "coupon_id"
    t.string "email"
    t.string "payment_id"
    t.string "error_message"
    t.string "customer_id"
    t.integer "payment_gateway"
    t.string "token"
    t.bigint "user_id", null: false
    t.integer "order_status"
    t.bigint "address_id", null: false
    t.index ["address_id"], name: "index_orders_on_address_id"
    t.index ["coupon_id"], name: "index_orders_on_coupon_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "product_attribute_values", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "attribute_value"
    t.integer "created_by"
    t.date "created_date"
    t.integer "modified_by"
    t.date "modified_date"
    t.bigint "product_attributes_id", null: false
    t.index ["product_attributes_id"], name: "index_product_attribute_values_on_product_attributes_id"
  end

  create_table "product_attributes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "created_by"
    t.date "created_date"
    t.integer "modified_by"
    t.date "modified_date"
  end

  create_table "product_attributes_assocs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_id", null: false
    t.bigint "product_attributes_id", null: false
    t.index ["product_attributes_id"], name: "index_product_attributes_assocs_on_product_attributes_id"
    t.index ["product_id"], name: "index_product_attributes_assocs_on_product_id"
  end

  create_table "product_categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id", null: false
    t.bigint "product_id", null: false
    t.index ["category_id"], name: "index_product_categories_on_category_id"
    t.index ["product_id"], name: "index_product_categories_on_product_id"
  end

  create_table "product_images", force: :cascade do |t|
    t.string "image_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "created_date"
    t.integer "created_by"
    t.integer "status", default: 0
    t.integer "modify_by"
    t.date "modify_date"
    t.bigint "product_id", null: false
    t.index ["product_id"], name: "index_product_images_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "sku"
    t.string "short_description"
    t.text "long_description"
    t.integer "price"
    t.decimal "special_price", precision: 14, scale: 2
    t.date "special_price_from"
    t.date "special_price_to"
    t.integer "quantity", default: 1
    t.string "meta_title"
    t.text "meta_description"
    t.text "meta_keywords"
    t.integer "status", default: 0
    t.integer "created_by"
    t.date "created_date"
    t.integer "modify_by"
    t.date "modify_date"
    t.string "stripe_plan_name"
  end

  create_table "sales_reports", force: :cascade do |t|
    t.string "total_saled_products"
    t.string "products_total_price"
    t.string "customers_registered"
    t.string "total_coupons"
    t.string "coupons_used"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "superadmin_role", default: false
    t.boolean "supervisor_role", default: false
    t.boolean "user_role", default: true
    t.string "firstname"
    t.string "lastname"
    t.integer "status", default: 0
    t.date "created_date"
    t.string "fb_token"
    t.string "twitter_token"
    t.string "google_token"
    t.integer "registration_method", default: 0
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wishlists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_wishlists_on_product_id"
    t.index ["user_id"], name: "index_wishlists_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "users"
  add_foreign_key "contacts", "users"
  add_foreign_key "coupons_useds", "coupons"
  add_foreign_key "coupons_useds", "users"
  add_foreign_key "order_details", "orders"
  add_foreign_key "order_details", "products"
  add_foreign_key "orders", "addresses"
  add_foreign_key "orders", "coupons"
  add_foreign_key "orders", "users"
  add_foreign_key "product_attribute_values", "product_attributes", column: "product_attributes_id"
  add_foreign_key "product_attributes_assocs", "product_attributes", column: "product_attributes_id"
  add_foreign_key "product_attributes_assocs", "products"
  add_foreign_key "product_categories", "categories"
  add_foreign_key "product_categories", "products"
  add_foreign_key "product_images", "products"
  add_foreign_key "wishlists", "products"
  add_foreign_key "wishlists", "users"
end
