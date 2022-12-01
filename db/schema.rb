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

ActiveRecord::Schema[7.0].define(version: 2022_12_01_180001) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercises", comment: "Exercise table", force: :cascade do |t|
    t.string "native", comment: "Word language word translation"
    t.string "ru", comment: "Russian word translation"
    t.string "input", comment: "User input"
    t.integer "status", default: 0, comment: "Status of exercise depending on user input"
    t.integer "locale", comment: "Locale of exercise for user input"
    t.bigint "user_id", comment: "Belongs to user"
    t.bigint "word_id", comment: "Belongs to word"
    t.bigint "round_id", comment: "Belongs to round"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["round_id"], name: "index_exercises_on_round_id"
    t.index ["user_id"], name: "index_exercises_on_user_id"
    t.index ["word_id"], name: "index_exercises_on_word_id"
  end

  create_table "languages", comment: "Keeps connection with all words of its language", force: :cascade do |t|
    t.string "name", null: false, comment: "language name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rounds", comment: "Аccumulates exercises with uniq words of a certain level", force: :cascade do |t|
    t.integer "level", comment: "Words level"
    t.integer "status", default: 0, comment: "Status to move the user to the next level"
    t.bigint "user_id", comment: "Belongs to user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_rounds_on_user_id"
  end

  create_table "users", comment: "Users table", force: :cascade do |t|
    t.integer "telegram_id", comment: "User's id in telegram"
    t.integer "level", default: 1, comment: "User's word level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "words", comment: "Words table", force: :cascade do |t|
    t.string "native", comment: "Associate language word translation"
    t.string "ru", comment: "Russian word translation"
    t.integer "locale", comment: "Locale of word for exercise check"
    t.integer "level", comment: "Word level"
    t.integer "rank", comment: "Word rank in 'Frequency lists/PG/2006/04'"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "language_id", comment: "Belongs to language"
    t.index ["language_id"], name: "index_words_on_language_id"
  end

end
