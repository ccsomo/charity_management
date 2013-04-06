# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130311022458) do

  create_table "donations", :force => true do |t|
    t.date     "date",                                        :null => false
    t.string   "type"
    t.integer  "group_id"
    t.integer  "person_id"
    t.integer  "service_id"
    t.decimal  "amount",       :precision => 10, :scale => 0
    t.decimal  "dollar_value", :precision => 10, :scale => 0
    t.string   "description"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "donations", ["group_id"], :name => "fk_donations_group"
  add_index "donations", ["person_id"], :name => "fk_donations_person"
  add_index "donations", ["service_id"], :name => "fk_donations_service"

  create_table "group_services", :force => true do |t|
    t.integer  "group_id",       :null => false
    t.integer  "service_id",     :null => false
    t.integer  "members_served", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "group_services", ["group_id", "service_id"], :name => "index_group_services_on_group_id_and_service_id", :unique => true
  add_index "group_services", ["service_id", "group_id"], :name => "index_group_services_on_service_id_and_group_id", :unique => true

  create_table "groups", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "members"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups_people", :id => false, :force => true do |t|
    t.integer "group_id",  :null => false
    t.integer "person_id", :null => false
  end

  add_index "groups_people", ["group_id", "person_id"], :name => "index_groups_people_on_group_id_and_person_id", :unique => true
  add_index "groups_people", ["person_id", "group_id"], :name => "index_groups_people_on_person_id_and_group_id", :unique => true

  create_table "people", :force => true do |t|
    t.string   "name"
    t.integer  "representative_id"
    t.string   "email"
    t.string   "street"
    t.string   "city"
    t.string   "state",             :limit => 2
    t.string   "zip",               :limit => 11
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "people", ["representative_id"], :name => "fk_people_representatives"

  create_table "people_services", :id => false, :force => true do |t|
    t.integer "person_id",  :null => false
    t.integer "service_id", :null => false
  end

  add_index "people_services", ["person_id", "service_id"], :name => "index_people_services_on_person_id_and_service_id", :unique => true
  add_index "people_services", ["service_id", "person_id"], :name => "index_people_services_on_service_id_and_person_id", :unique => true

  create_table "people_skills", :id => false, :force => true do |t|
    t.integer "person_id", :null => false
    t.integer "skill_id",  :null => false
  end

  add_index "people_skills", ["person_id", "skill_id"], :name => "index_people_skills_on_person_id_and_skill_id", :unique => true
  add_index "people_skills", ["skill_id", "person_id"], :name => "index_people_skills_on_skill_id_and_person_id", :unique => true

  create_table "places", :force => true do |t|
    t.string   "city",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "services", :force => true do |t|
    t.date     "date",                                 :null => false
    t.integer  "place_id",                             :null => false
    t.string   "description",                          :null => false
    t.text     "notes"
    t.integer  "hours",                                :null => false
    t.boolean  "sent_survey",       :default => false
    t.boolean  "returned_survey",   :default => false
    t.boolean  "trained",           :default => false
    t.boolean  "willing_to_return", :default => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "services", ["place_id"], :name => "fk_service_place"

  create_table "skills", :force => true do |t|
    t.string   "description", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "skills", ["description"], :name => "index_skills_on_description", :unique => true

end
