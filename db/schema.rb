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

ActiveRecord::Schema.define(:version => 20110802003715) do

  create_table "developers", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "fid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "developers", ["fid"], :name => "index_developers_on_fid", :unique => true
  add_index "developers", ["slug"], :name => "index_developers_on_slug", :unique => true

  create_table "figures", :force => true do |t|
    t.integer  "variation_id"
    t.integer  "price_cents"
    t.integer  "amount_saved_cents"
    t.string   "currency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "franchises", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "franchises", ["slug"], :name => "index_franchises_on_slug", :unique => true

  create_table "game_developers", :force => true do |t|
    t.integer  "game_id"
    t.integer  "developer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "game_developers", ["developer_id"], :name => "index_game_developers_on_developer_id"
  add_index "game_developers", ["game_id"], :name => "index_game_developers_on_game_id"

  create_table "game_genres", :force => true do |t|
    t.integer  "game_id"
    t.integer  "genre_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "game_genres", ["game_id"], :name => "index_game_genres_on_game_id"
  add_index "game_genres", ["genre_id"], :name => "index_game_genres_on_genre_id"

  create_table "game_platforms", :force => true do |t|
    t.integer  "game_id"
    t.integer  "platform_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "game_platforms", ["game_id"], :name => "index_game_platforms_on_game_id"
  add_index "game_platforms", ["platform_id"], :name => "index_game_platforms_on_platform_id"

  create_table "games", :force => true do |t|
    t.integer  "franchise_id"
    t.string   "name"
    t.string   "slug"
    t.integer  "fid"
    t.date     "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "games", ["fid"], :name => "index_games_on_fid", :unique => true
  add_index "games", ["slug"], :name => "index_games_on_slug", :unique => true

  create_table "genres", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "fid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "genres", ["fid"], :name => "index_genres_on_fid", :unique => true
  add_index "genres", ["slug"], :name => "index_genres_on_slug", :unique => true

  create_table "images", :force => true do |t|
    t.integer  "product_id"
    t.string   "url"
    t.string   "url_75px"
    t.string   "url_160px"
    t.string   "url_500px"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["product_id"], :name => "index_images_on_product_id"

  create_table "merchants", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "merchants", ["slug"], :name => "index_merchants_on_slug", :unique => true

  create_table "platforms", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "fid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "platforms", ["fid"], :name => "index_platforms_on_fid", :unique => true
  add_index "platforms", ["slug"], :name => "index_platforms_on_slug", :unique => true

  create_table "product_types", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.decimal  "rank",       :precision => 3, :scale => 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
  end

  add_index "product_types", ["ancestry"], :name => "index_product_types_on_ancestry"
  add_index "product_types", ["slug"], :name => "index_product_types_on_slug", :unique => true

  create_table "products", :force => true do |t|
    t.integer  "game_id"
    t.integer  "franchise_id"
    t.integer  "product_type_id"
    t.integer  "merchant_id"
    t.string   "slug"
    t.string   "name"
    t.string   "url"
    t.string   "short_desc"
    t.text     "description"
    t.text     "features"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["game_id"], :name => "index_products_on_game_id"
  add_index "products", ["product_type_id"], :name => "index_products_on_product_type_id"
  add_index "products", ["slug"], :name => "index_products_on_slug", :unique => true

  create_table "searches", :force => true do |t|
    t.string   "query"
    t.integer  "num_results"
    t.string   "ip_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                              :default => "", :null => false
    t.string   "encrypted_password",  :limit => 128, :default => "", :null => false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                    :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "variations", :force => true do |t|
    t.integer  "product_id"
    t.string   "size"
    t.string   "color"
    t.boolean  "in_stock"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "variations", ["product_id"], :name => "index_variations_on_product_id"

end
