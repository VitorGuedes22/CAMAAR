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

ActiveRecord::Schema[7.1].define(version: 2024_07_03_184752) do
  create_table "course_classes", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "classCode"
    t.string "semester"
    t.string "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "course_class_id", null: false
    t.string "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_class_id"], name: "index_memberships_on_course_class_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "options", force: :cascade do |t|
    t.string "text"
    t.integer "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_options_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "title"
    t.string "question_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "senha"
    t.string "nome"
    t.string "curso"
    t.string "matricula"
    t.string "usuario"
    t.string "formacao"
    t.string "ocupacao"
    t.string "departamento"
    t.string "password_digest"
  end

  add_foreign_key "memberships", "course_classes"
  add_foreign_key "memberships", "users"
  add_foreign_key "options", "questions"
end
