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

ActiveRecord::Schema.define(version: 2022_03_26_210413) do

  create_table "engines", force: :cascade do |t|
    t.integer "user_id"
    t.integer "cylinders"
    t.integer "valves_per_cylinder"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "intake_min", precision: 4, scale: 2
    t.decimal "intake_max", precision: 4, scale: 2
    t.decimal "exhaust_min", precision: 4, scale: 2
    t.decimal "exhaust_max", precision: 4, scale: 2
  end

  create_table "shims", force: :cascade do |t|
    t.integer "engine_id", null: false
    t.integer "size_mm"
    t.boolean "in_use"
    t.integer "cylinder"
    t.string "valve"
    t.integer "valve_num"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["engine_id"], name: "index_shims_on_engine_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "shims", "engines"
end
