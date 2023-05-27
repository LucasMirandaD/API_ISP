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

ActiveRecord::Schema[7.0].define(version: 4) do
  create_table "clients", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "nickname"
    t.string "password"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "isps", charset: "utf8mb4", force: :cascade do |t|
    t.string "name_isp"
    t.string "password"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plans", charset: "utf8mb4", force: :cascade do |t|
    t.string "name_plan"
    t.bigint "isp_id"
    t.string "band_width"
    t.boolean "simetric"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["isp_id"], name: "index_plans_on_isp_id"
  end

  create_table "requests", charset: "utf8mb4", force: :cascade do |t|
    t.string "numberRequest"
    t.boolean "acceptRequest"
    t.bigint "client_id"
    t.bigint "plan_id"
    t.bigint "isp_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_requests_on_client_id"
    t.index ["isp_id"], name: "index_requests_on_isp_id"
    t.index ["plan_id"], name: "index_requests_on_plan_id"
  end

  add_foreign_key "plans", "isps"
  add_foreign_key "requests", "clients"
  add_foreign_key "requests", "isps"
  add_foreign_key "requests", "plans"
end
