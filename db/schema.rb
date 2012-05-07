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

ActiveRecord::Schema.define(:version => 20120411044529) do

  create_table "admins", :force => true do |t|
    t.string   "name",         :null => false
    t.string   "phone_number", :null => false
    t.string   "email",        :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "batches", :force => true do |t|
    t.string   "description",                     :null => false
    t.date     "start_date",                      :null => false
    t.date     "end_date",                        :null => false
    t.string   "group",       :default => "pcmb", :null => false
    t.string   "incharge",                        :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "batchstudents", :force => true do |t|
    t.integer  "batch_id",                          :null => false
    t.integer  "student_id",                        :null => false
    t.string   "report",     :default => "average", :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "batchtests", :force => true do |t|
    t.integer  "batch_id",        :null => false
    t.integer  "jktest_id",       :null => false
    t.date     "start_test_date", :null => false
    t.date     "end_test_date",   :null => false
    t.integer  "attempt",         :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "chapters", :force => true do |t|
    t.integer  "subject_id",     :null => false
    t.integer  "chapter_number", :null => false
    t.string   "name",           :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "forums", :force => true do |t|
    t.string   "description", :null => false
    t.string   "title",       :null => false
    t.integer  "topic_id",    :null => false
    t.integer  "user_id",     :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "jktests", :force => true do |t|
    t.string   "name",            :null => false
    t.integer  "subject_id",      :null => false
    t.integer  "user_id",         :null => false
    t.string   "chapters_id",     :null => false
    t.integer  "no_of_questions", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "marks", :force => true do |t|
    t.integer  "batchtest_id", :null => false
    t.integer  "student_id",   :null => false
    t.integer  "mark",         :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "post",         :null => false
    t.integer  "user_id",      :null => false
    t.integer  "forum_id",     :null => false
    t.integer  "post_post_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "questions", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "topic_id",   :null => false
    t.string   "question",   :null => false
    t.string   "option_a",   :null => false
    t.string   "option_b",   :null => false
    t.string   "option_c",   :null => false
    t.string   "option_d",   :null => false
    t.string   "answer",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "solvedtests", :force => true do |t|
    t.integer  "batchtest_id",     :null => false
    t.integer  "user_id",          :null => false
    t.string   "questions_id",     :null => false
    t.string   "questions_answer", :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "students", :force => true do |t|
    t.string   "name",           :null => false
    t.string   "address",        :null => false
    t.string   "phone_number",   :null => false
    t.string   "group",          :null => false
    t.integer  "standerd",       :null => false
    t.float    "ssc_marks",      :null => false
    t.string   "email",          :null => false
    t.string   "parent_contact", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "subjects", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teachers", :force => true do |t|
    t.string   "name",         :null => false
    t.string   "phone_number", :null => false
    t.string   "address",      :null => false
    t.integer  "subject_id",   :null => false
    t.string   "email",        :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "testattempts", :force => true do |t|
    t.integer  "batchtest_id", :null => false
    t.integer  "student_id",   :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "testquestions", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "jktest_id",   :null => false
    t.integer  "question_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "topics", :force => true do |t|
    t.integer  "chapter_id",                :null => false
    t.integer  "user_id",                   :null => false
    t.string   "name",                      :null => false
    t.integer  "priority",   :default => 2, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.integer  "role_id",                :default => 1,  :null => false
    t.integer  "employee_id",            :default => 1,  :null => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
