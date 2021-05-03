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

ActiveRecord::Schema.define(version: 2021_04_26_215535) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "nominations", force: :cascade do |t|
    t.bigint "nominator_id"
    t.bigint "nominated_id"
    t.boolean "accepted", default: false
    t.boolean "co_worker"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["nominated_id"], name: "index_nominations_on_nominated_id"
    t.index ["nominator_id"], name: "index_nominations_on_nominator_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "github_username"
    t.integer "github_id"
    t.string "avatar"
    t.string "email"
    t.string "jwt_token"
    t.boolean "admin", default: false
    t.integer "score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
