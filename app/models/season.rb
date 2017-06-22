class Season < ApplicationRecord
  has_many :teams, :through => :season_teams
  has_many :season_teams
  has_many :game_dates
  has_many :players
end
