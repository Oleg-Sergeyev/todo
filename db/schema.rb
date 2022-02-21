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

ActiveRecord::Schema.define(version: 2022_02_21_092304) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "comments", comment: "Комментарии пользователей", force: :cascade do |t|
    t.text "content", comment: "Содержимое сообщения"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "commentable_type", null: false
    t.bigint "commentable_id", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "events", comment: "Список дел", force: :cascade do |t|
    t.string "name", comment: "Заголовок"
    t.text "content", comment: "Детальное описание"
    t.boolean "done", default: false, comment: "Статус: завершено (true), или нет (false)"
    t.datetime "finished_at", comment: "Дата и время завершения дела"
    t.bigint "user_id", comment: "Внешний ключ для связи с таблицей users"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "items", comment: "Подпункты дела", force: :cascade do |t|
    t.string "name", comment: "Заголовок"
    t.boolean "done", default: false, comment: "Статус: завершено (true), или нет (false)"
    t.datetime "finished_at", comment: "Дата и время завершения подпункта"
    t.bigint "event_id", comment: "Внешний ключ для связи с таблицей events"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_items_on_event_id"
  end

  create_table "roles", comment: "Роли пользователя", force: :cascade do |t|
    t.string "name", comment: "Заголовок"
    t.string "code", comment: "Псевдоним"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "seos", comment: "Теги для поисковых ситем", force: :cascade do |t|
    t.string "title", comment: "Тег title"
    t.string "description", comment: "Тег desription"
    t.string "keywords", comment: "Тег keywords"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "promoted_type", null: false
    t.bigint "promoted_id", null: false
    t.index ["promoted_type", "promoted_id"], name: "index_seos_on_promoted"
  end

  create_table "users", comment: "Пользователи системы", force: :cascade do |t|
    t.string "name", comment: "Имя, которое используется для входа"
    t.string "email", comment: "Электронный адрес пользователя"
    t.boolean "active", default: true, comment: "пользователь активен (true) или заблокирован (false)"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role_id", comment: "Роль пользователя"
    t.integer "events_ffd_count"
    t.integer "events_unffd_count"
    t.integer "events_count"
    t.integer "items_count"
    t.integer "items_ffd_count"
    t.integer "items_unffd_count"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "authentication_token"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "comments", "users"
  add_foreign_key "events", "users"
  add_foreign_key "items", "events"
  add_foreign_key "users", "roles"
end
