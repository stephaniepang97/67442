# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20181022152534) do

  create_table "families", force: :cascade do |t|
    t.string "family_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patient_sessions", force: :cascade do |t|
    t.integer "patient_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string "question"
    t.string "answer"
    t.integer "created_by"
    t.string "attachment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "session_questions", force: :cascade do |t|
    t.integer "patient_sessions_id"
    t.integer "questions_id"
    t.boolean "correct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "answered_correctly"
    t.index ["patient_sessions_id"], name: "index_session_questions_on_patient_sessions_id"
    t.index ["questions_id"], name: "index_session_questions_on_questions_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "role"
    t.integer "family_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
