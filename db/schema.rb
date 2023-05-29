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

ActiveRecord::Schema[7.0].define(version: 2023_05_25_074027) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chasks", force: :cascade do |t|
    t.string "title"
    t.string "status", default: "pending"
    t.bigint "task_id", null: false
    t.bigint "chask_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "deadline"
    t.index ["chask_id"], name: "index_chasks_on_chask_id"
    t.index ["task_id"], name: "index_chasks_on_task_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.bigint "chask_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chask_id"], name: "index_messages_on_chask_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "user_type", null: false
    t.bigint "user_id", null: false
    t.string "object_type", null: false
    t.bigint "object_id", null: false
    t.string "message"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["object_type", "object_id"], name: "index_notifications_on_object"
    t.index ["user_type", "user_id"], name: "index_notifications_on_user"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.boolean "completed", default: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "deadline"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "totalpoints", default: 0
    t.integer "daypoints", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "chasks", "chasks"
  add_foreign_key "chasks", "tasks"
  add_foreign_key "messages", "chasks"
  add_foreign_key "messages", "users"
  add_foreign_key "tasks", "users"
end
