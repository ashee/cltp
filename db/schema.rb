# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100524171901) do

  create_table "clerkships", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "encounters", :force => true do |t|
    t.string   "pid"
    t.string   "age"
    t.string   "gender"
    t.string   "patient_type"
    t.text     "chief_complaint"
    t.string   "co_mobidity"
    t.string   "student"
    t.string   "academic_year"
    t.string   "period"
    t.string   "clerkship"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "procedures_performed"
    t.string   "procedures_observed"
    t.boolean  "history_taken"
    t.boolean  "physical_exam_taken"
    t.text     "notes"
    t.string   "site"
  end

  create_table "periods", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resources", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.string   "from"
    t.string   "owner"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
