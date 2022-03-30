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

ActiveRecord::Schema[7.0].define(version: 2022_03_30_004930) do
  create_table "cylinders", force: :cascade do |t|
    t.integer "engine_id", null: false
    t.integer "cylinder_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["engine_id"], name: "index_cylinders_on_engine_id"
  end

  create_table "engines", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "num_cylinders"
    t.integer "valves_per_cylinder"
    t.string "name"
    t.decimal "intake_min", precision: 4, scale: 2
    t.decimal "intake_max", precision: 4, scale: 2
    t.decimal "exhaust_min", precision: 4, scale: 2
    t.decimal "exhaust_max", precision: 4, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_engines_on_user_id"
  end

  create_table "shims", force: :cascade do |t|
    t.integer "valve_id", null: false
    t.integer "size_mm"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "valves", force: :cascade do |t|
    t.integer "cylinder_id", null: false
    t.decimal "gap", precision: 4, scale: 2
    t.string "intake_or_exhaust"
    t.integer "valve_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cylinder_id"], name: "index_valves_on_cylinder_id"
  end

  add_foreign_key "cylinders", "engines"
  add_foreign_key "engines", "users"
  add_foreign_key "shims", "valves"
  add_foreign_key "valves", "cylinders"
end
