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

ActiveRecord::Schema.define(version: 20170619080523) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batter_stats", force: :cascade do |t|
    t.integer "batter_id"
    t.string  "stat_type"
    t.integer "woba",      default: 0
    t.integer "ops",       default: 0
    t.integer "ab",        default: 0
    t.integer "so",        default: 0
    t.integer "bb",        default: 0
    t.integer "sb",        default: 0
    t.integer "obp",       default: 0
    t.integer "slg",       default: 0
    t.integer "wrc",       default: 0
    t.float   "fb",        default: 0.0
    t.float   "gb",        default: 0.0
    t.float   "ld",        default: 0.0
    t.index ["batter_id"], name: "index_batter_stats_on_batter_id", using: :btree
  end

  create_table "batters", force: :cascade do |t|
    t.integer "intervalable_id"
    t.string  "intervalable_type"
    t.integer "statable_id"
    t.string  "statable_type"
    t.string  "position"
    t.string  "lineup"
    t.boolean "starter",           default: false
    t.index ["intervalable_id"], name: "index_batters_on_intervalable_id", using: :btree
    t.index ["statable_id"], name: "index_batters_on_statable_id", using: :btree
  end

  create_table "game_dates", force: :cascade do |t|
    t.integer "season_id"
    t.date    "date"
    t.index ["season_id"], name: "index_game_dates_on_season_id", using: :btree
  end

  create_table "games", force: :cascade do |t|
    t.integer "game_date_id"
    t.integer "away_team_id"
    t.integer "home_team_id"
    t.integer "num"
    t.integer "hour"
    t.integer "minutes"
    t.string  "ump"
    t.index ["away_team_id"], name: "index_games_on_away_team_id", using: :btree
    t.index ["game_date_id"], name: "index_games_on_game_date_id", using: :btree
    t.index ["home_team_id"], name: "index_games_on_home_team_id", using: :btree
  end

  create_table "pitcher_stats", force: :cascade do |t|
    t.integer "pitcher_id"
    t.string  "stat_type"
    t.integer "h",          default: 0
    t.integer "so",         default: 0
    t.integer "bb",         default: 0
    t.integer "fip",        default: 0
    t.integer "woba",       default: 0
    t.integer "ops",        default: 0
    t.integer "siera",      default: 0
    t.float   "ip",         default: 0.0
    t.float   "era",        default: 0.0
    t.float   "whip",       default: 0.0
    t.float   "xfip",       default: 0.0
    t.float   "kbb",        default: 0.0
    t.float   "fb",         default: 0.0
    t.float   "gb",         default: 0.0
    t.float   "ld",         default: 0.0
    t.index ["pitcher_id"], name: "index_pitcher_stats_on_pitcher_id", using: :btree
  end

  create_table "pitchers", force: :cascade do |t|
    t.integer "intervalable_id"
    t.string  "intervalable_type"
    t.integer "statable_id"
    t.string  "statable_type"
    t.boolean "starter",           default: false
    t.boolean "bullpen",           default: false
    t.index ["intervalable_id"], name: "index_pitchers_on_intervalable_id", using: :btree
    t.index ["statable_id"], name: "index_pitchers_on_statable_id", using: :btree
  end

  create_table "players", force: :cascade do |t|
    t.integer "season_id"
    t.integer "team_id"
    t.string  "name"
    t.string  "identity"
    t.integer "fangraph_id"
    t.string  "bathand"
    t.string  "throwhand"
    t.index ["season_id"], name: "index_players_on_season_id", using: :btree
    t.index ["team_id"], name: "index_players_on_team_id", using: :btree
  end

  create_table "season_teams", force: :cascade do |t|
    t.integer "season_id"
    t.integer "team_id"
    t.index ["season_id"], name: "index_season_teams_on_season_id", using: :btree
    t.index ["team_id"], name: "index_season_teams_on_team_id", using: :btree
  end

  create_table "seasons", force: :cascade do |t|
    t.integer "year"
  end

  create_table "teams", force: :cascade do |t|
    t.string  "name"
    t.string  "abbr"
    t.string  "alt_abbr"
    t.integer "fangraph_id"
    t.string  "stadium"
    t.string  "zipcode"
    t.string  "league"
    t.string  "division"
    t.string  "city"
    t.integer "timezone"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
  end

end
