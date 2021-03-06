# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_25_023912) do

  create_table "action_text_rich_texts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false
    t.text "body", size: :long
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "cad_operations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "session_id"
    t.string "cmd_name"
    t.integer "cmd_seconds"
    t.text "cmd_data"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_cad_operations_on_user_id"
  end

  create_table "cad_sessions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "session"
    t.string "operation"
    t.string "ip_address"
    t.string "mac_address"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "begin_operation"
    t.string "end_operation"
    t.index ["user_id"], name: "index_cad_sessions_on_user_id"
  end

  create_table "copy_of_business_license_applies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "employee_name"
    t.string "clerk_code"
    t.string "belong_company_name"
    t.string "belong_department_name"
    t.string "contract_belong_company"
    t.string "stamp_to_place"
    t.string "stamp_comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "begin_task_id"
    t.boolean "backend_in_processing"
    t.text "bpm_message"
    t.string "belong_company_code"
    t.string "belong_department_code"
    t.string "contract_belong_company_code"
    t.string "status"
    t.index ["user_id"], name: "index_copy_of_business_license_applies_on_user_id"
  end

  create_table "department_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.bigint "department_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id"], name: "index_department_users_on_department_id"
    t.index ["user_id"], name: "index_department_users_on_user_id"
  end

  create_table "departments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "company_name"
    t.string "dept_code"
    t.string "company_code"
  end

  create_table "direct_question_answers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.bigint "knowledge_id", null: false
    t.bigint "direct_question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["direct_question_id"], name: "index_direct_question_answers_on_direct_question_id"
    t.index ["knowledge_id"], name: "index_direct_question_answers_on_knowledge_id"
  end

  create_table "direct_questions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "question"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "knowledge_likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "like_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_knowledge_likes_on_user_id"
  end

  create_table "knowledges", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "category_1"
    t.string "category_2"
    t.string "question", collation: "utf8_general_ci"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "category_3"
    t.boolean "shanghai_only", default: false
  end

  create_table "name_card_applies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "english_name"
    t.string "department_name"
    t.string "en_department_name"
    t.string "title"
    t.string "en_title"
    t.string "phone_ext"
    t.string "fax_no"
    t.string "mobile"
    t.integer "print_out_box_number"
    t.string "begin_task_id"
    t.text "bpm_message"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "company_name"
    t.string "en_company_name"
    t.string "comment"
    t.string "office_address"
    t.string "office_level"
    t.string "professional_title"
    t.string "en_professional_title"
    t.string "chinese_name"
    t.string "email"
    t.boolean "backend_in_processing", default: false
    t.string "thickness"
    t.string "back_color"
    t.index ["user_id"], name: "index_name_card_applies_on_user_id"
  end

  create_table "name_card_black_titles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "original_title"
    t.string "required_title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "name_card_white_titles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "original_title"
    t.string "required_title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "official_stamp_usage_applies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.bigint "user_id"
    t.string "employee_name"
    t.string "clerk_code"
    t.string "belong_company_name"
    t.string "belong_company_code"
    t.string "belong_department_name"
    t.string "belong_department_code"
    t.string "application_class"
    t.string "stamp_to_place"
    t.string "stamp_comment"
    t.string "begin_task_id"
    t.string "backend_in_processing"
    t.text "bpm_message"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "application_subclasses", default: "--- []\n"
    t.index ["user_id"], name: "index_official_stamp_usage_applies_on_user_id"
  end

  create_table "pending_questions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "question"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "owner_id"
    t.index ["owner_id"], name: "index_pending_questions_on_owner_id"
    t.index ["user_id"], name: "index_pending_questions_on_user_id"
  end

  create_table "proof_of_employment_applies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.bigint "user_id"
    t.string "employee_name"
    t.string "clerk_code"
    t.string "belong_company_name"
    t.string "belong_department_name"
    t.string "contract_belong_company"
    t.string "stamp_to_place"
    t.string "stamp_comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "begin_task_id"
    t.boolean "backend_in_processing"
    t.text "bpm_message"
    t.string "belong_company_code"
    t.string "belong_department_code"
    t.string "contract_belong_company_code"
    t.string "status"
    t.index ["user_id"], name: "index_proof_of_employment_applies_on_user_id"
  end

  create_table "proof_of_income_applies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "employee_name"
    t.string "clerk_code"
    t.string "belong_company_name"
    t.string "belong_department_name"
    t.string "contract_belong_company"
    t.string "stamp_to_place"
    t.string "stamp_comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "begin_task_id"
    t.boolean "backend_in_processing"
    t.text "bpm_message"
    t.string "belong_company_code"
    t.string "belong_department_code"
    t.string "contract_belong_company_code"
    t.string "status"
    t.index ["user_id"], name: "index_proof_of_income_applies_on_user_id"
  end

  create_table "public_rental_housing_applies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "employee_name"
    t.string "clerk_code"
    t.string "belong_company_name"
    t.string "belong_department_name"
    t.string "contract_belong_company"
    t.string "stamp_to_place"
    t.string "stamp_comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "begin_task_id"
    t.boolean "backend_in_processing"
    t.text "bpm_message"
    t.string "belong_company_code"
    t.string "belong_department_code"
    t.string "contract_belong_company_code"
    t.string "status"
    t.index ["user_id"], name: "index_public_rental_housing_applies_on_user_id"
  end

  create_table "role_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role_id"], name: "index_role_users_on_role_id"
    t.index ["user_id"], name: "index_role_users_on_user_id"
  end

  create_table "roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "role_name"
    t.boolean "report_viewer"
    t.boolean "report_reviewer"
    t.boolean "knowledge_maintainer"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "cad_session"
    t.boolean "report_view_all"
    t.boolean "project_map_viewer"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "position_title"
    t.string "clerk_code"
    t.string "chinese_name"
    t.string "desk_phone"
    t.string "job_level"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "wechat_sessions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "openid", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "greating_time"
    t.index ["openid"], name: "index_wechat_sessions_on_openid", unique: true
  end

  create_table "whitelisted_jwts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "jti", null: false
    t.string "aud", null: false
    t.datetime "exp", null: false
    t.bigint "user_id", null: false
    t.index ["jti"], name: "index_whitelisted_jwts_on_jti", unique: true
    t.index ["user_id"], name: "index_whitelisted_jwts_on_user_id"
  end

  create_table "yingjianke_overrun_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.datetime "time"
    t.string "device"
    t.decimal "stay_timespan", precision: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cad_operations", "users"
  add_foreign_key "copy_of_business_license_applies", "users"
  add_foreign_key "direct_question_answers", "direct_questions"
  add_foreign_key "direct_question_answers", "knowledges"
  add_foreign_key "knowledge_likes", "users"
  add_foreign_key "name_card_applies", "users"
  add_foreign_key "proof_of_income_applies", "users"
  add_foreign_key "public_rental_housing_applies", "users"
  add_foreign_key "whitelisted_jwts", "users", on_delete: :cascade
end
