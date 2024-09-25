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

ActiveRecord::Schema[7.2].define(version: 2024_09_25_115911) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coourse_announcements", force: :cascade do |t|
    t.bigint "coourse_id", null: false
    t.string "title", null: false
    t.text "content"
    t.datetime "start_at", null: false
    t.datetime "end_at", null: false
    t.bigint "creator_id", null: false
    t.bigint "updater_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coourse_id"], name: "index_coourse_announcements_on_coourse_id"
    t.index ["creator_id"], name: "index_coourse_announcements_on_creator_id"
    t.index ["updater_id"], name: "index_coourse_announcements_on_updater_id"
  end

  create_table "coourses", force: :cascade do |t|
    t.bigint "instance_id", null: false
    t.string "title", null: false
    t.text "description"
    t.integer "status", default: 0, null: false
    t.datetime "start_at", null: false
    t.datetime "end_at", null: false
    t.bigint "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_coourses_on_creator_id"
    t.index ["instance_id"], name: "index_coourses_on_instance_id"
  end

  create_table "instance_announcements", force: :cascade do |t|
    t.bigint "instance_id", null: false
    t.string "title", null: false
    t.text "content"
    t.datetime "start_at", null: false
    t.datetime "end_at", null: false
    t.bigint "creator_id", null: false
    t.bigint "updater_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_instance_announcements_on_creator_id"
    t.index ["instance_id"], name: "index_instance_announcements_on_instance_id"
    t.index ["updater_id"], name: "index_instance_announcements_on_updater_id"
  end

  create_table "instance_users", force: :cascade do |t|
    t.bigint "instance_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instance_id", "user_id"], name: "index_instance_users_on_instance_id_and_user_id", unique: true
    t.index ["instance_id"], name: "index_instance_users_on_instance_id"
    t.index ["user_id"], name: "index_instance_users_on_user_id"
  end

  create_table "instances", force: :cascade do |t|
    t.string "host", null: false, comment: "Stores the host name of the instance. The www prefix is automatically handled by the application"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["host"], name: "index_instances_on_host", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "name", null: false
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "web_sites", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "coourse_announcements", "users", column: "creator_id", name: "fk_coourse_announcements_creator_id"
  add_foreign_key "coourse_announcements", "users", column: "updater_id", name: "fk_coourse_announcements_updater_id"
  add_foreign_key "coourses", "users", column: "creator_id", name: "fk_courses_creator_id"
  add_foreign_key "instance_announcements", "users", column: "creator_id", name: "fk_instance_announcements_creator_id"
  add_foreign_key "instance_announcements", "users", column: "updater_id", name: "fk_instance_announcements_updater_id"
end
