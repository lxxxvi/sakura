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

ActiveRecord::Schema[7.1].define(version: 2024_08_23_124011) do
  create_table "exercise_items", force: :cascade do |t|
    t.string "url_identifier", default: -> { "lower(hex(randomblob(2)))" }, null: false
    t.integer "exercise_id", null: false
    t.integer "position", null: false
    t.string "from_language_iso", null: false
    t.string "from_word_value", null: false
    t.string "to_language_iso", null: false
    t.json "possible_solutions", null: false
    t.string "given_answer"
    t.integer "score", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id", "position"], name: "index_exercise_items_on_exercise_id_and_position", unique: true
    t.index ["exercise_id", "url_identifier"], name: "index_exercise_items_on_exercise_id_and_url_identifier", unique: true
    t.index ["exercise_id"], name: "index_exercise_items_on_exercise_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "url_identifier", default: -> { "lower(hex(randomblob(5)))" }, null: false
    t.datetime "started_at", null: false
    t.datetime "ended_at"
    t.integer "completion_percentage", default: 0, null: false
    t.integer "score_percentage", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "url_identifier"], name: "index_exercises_on_user_id_and_url_identifier", unique: true
    t.index ["user_id"], name: "index_exercises_on_user_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "iso", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["iso"], name: "index_languages_on_iso", unique: true
  end

  create_table "translations", force: :cascade do |t|
    t.integer "word_id", null: false
    t.integer "target_word_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_word_id"], name: "index_translations_on_target_word_id"
    t.index ["word_id"], name: "index_translations_on_word_id"
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

  create_table "words", force: :cascade do |t|
    t.integer "language_id", null: false
    t.string "value", null: false
    t.integer "also_written_as_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["also_written_as_id"], name: "index_words_on_also_written_as_id"
    t.index ["language_id", "value"], name: "index_words_on_language_id_and_value", unique: true
    t.index ["language_id"], name: "index_words_on_language_id"
  end

  add_foreign_key "exercise_items", "exercises"
  add_foreign_key "translations", "words"
  add_foreign_key "translations", "words", column: "target_word_id"
  add_foreign_key "words", "words", column: "also_written_as_id"
end
