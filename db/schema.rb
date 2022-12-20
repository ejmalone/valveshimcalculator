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

ActiveRecord::Schema[7.0].define(version: 2022_12_19_221145) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adders", force: :cascade do |t|
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "anonymous_users", force: :cascade do |t|
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["token"], name: "index_anonymous_users_on_token", unique: true
    t.index ["user_id"], name: "index_anonymous_users_on_user_id"
  end

  create_table "cylinders", force: :cascade do |t|
    t.bigint "engine_id", null: false
    t.integer "cylinder_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["engine_id"], name: "index_cylinders_on_engine_id"
  end

  create_table "engines", force: :cascade do |t|
    t.integer "num_cylinders"
    t.integer "valves_per_cylinder"
    t.string "nickname"
    t.decimal "intake_min", precision: 4, scale: 2
    t.decimal "intake_max", precision: 4, scale: 2
    t.decimal "exhaust_min", precision: 4, scale: 2
    t.decimal "exhaust_max", precision: 4, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "userable_type"
    t.integer "userable_id"
    t.string "make"
    t.string "model"
    t.index ["userable_type", "userable_id"], name: "index_engines_on_userable_type_and_userable_id"
  end

  create_table "shims", force: :cascade do |t|
    t.integer "valve_id"
    t.integer "thickness"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "engine_id"
    t.index ["engine_id"], name: "index_shims_on_engine_id"
    t.index ["valve_id"], name: "index_shims_on_valve_id"
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

  create_table "valve_adjustments", force: :cascade do |t|
    t.bigint "engine_id", null: false
    t.integer "mileage"
    t.date "adjustment_date"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.json "valve_state"
    t.index ["engine_id"], name: "index_valve_adjustments_on_engine_id"
  end

  create_table "valves", force: :cascade do |t|
    t.bigint "cylinder_id", null: false
    t.decimal "gap", precision: 4, scale: 2
    t.string "intake_or_exhaust"
    t.integer "valve_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cylinder_id"], name: "index_valves_on_cylinder_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "anonymous_users", "users"
  add_foreign_key "cylinders", "engines"
  add_foreign_key "shims", "engines"
  add_foreign_key "valve_adjustments", "engines"
  add_foreign_key "valves", "cylinders"
end
