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

ActiveRecord::Schema[7.0].define(version: 2023_08_18_003755) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "business_areas", force: :cascade do |t|
    t.string "name"
    t.string "detail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_business_areas_on_name", unique: true
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "sub_name"
    t.string "address"
    t.date "date_start"
    t.string "phone_number"
    t.string "managed_by"
    t.bigint "represent_id", null: false
    t.bigint "city_id", null: false
    t.bigint "district_id", null: false
    t.bigint "ward_id", null: false
    t.bigint "company_type_id", null: false
    t.bigint "business_area_id"
    t.bigint "status_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_area_id"], name: "index_companies_on_business_area_id"
    t.index ["city_id"], name: "index_companies_on_city_id"
    t.index ["company_type_id"], name: "index_companies_on_company_type_id"
    t.index ["district_id"], name: "index_companies_on_district_id"
    t.index ["represent_id"], name: "index_companies_on_represent_id"
    t.index ["status_id"], name: "index_companies_on_status_id"
    t.index ["ward_id"], name: "index_companies_on_ward_id"
  end

  create_table "company_types", force: :cascade do |t|
    t.string "type_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "districts", force: :cascade do |t|
    t.string "name"
    t.bigint "city_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_districts_on_city_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "cmnd"
    t.string "address"
    t.date "date_start"
    t.string "phone_number"
    t.string "managed_by"
    t.bigint "city_id", null: false
    t.bigint "district_id", null: false
    t.bigint "ward_id", null: false
    t.bigint "company_type_id", null: false
    t.bigint "status_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_people_on_city_id"
    t.index ["cmnd"], name: "index_people_on_cmnd", unique: true
    t.index ["company_type_id"], name: "index_people_on_company_type_id"
    t.index ["district_id"], name: "index_people_on_district_id"
    t.index ["status_id"], name: "index_people_on_status_id"
    t.index ["ward_id"], name: "index_people_on_ward_id"
  end

  create_table "represents", force: :cascade do |t|
    t.string "name"
    t.date "day_of_birth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tax_codes", force: :cascade do |t|
    t.string "code"
    t.string "taxable_type", null: false
    t.bigint "taxable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_tax_codes_on_code", unique: true
    t.index ["taxable_type", "taxable_id"], name: "index_tax_codes_on_taxable_type_and_taxable_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wards", force: :cascade do |t|
    t.string "name"
    t.bigint "district_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["district_id"], name: "index_wards_on_district_id"
  end

  add_foreign_key "companies", "business_areas"
  add_foreign_key "companies", "cities"
  add_foreign_key "companies", "company_types"
  add_foreign_key "companies", "districts"
  add_foreign_key "companies", "represents"
  add_foreign_key "companies", "statuses"
  add_foreign_key "companies", "wards"
  add_foreign_key "districts", "cities"
  add_foreign_key "people", "cities"
  add_foreign_key "people", "company_types"
  add_foreign_key "people", "districts"
  add_foreign_key "people", "statuses"
  add_foreign_key "people", "wards"
  add_foreign_key "wards", "districts"
end
