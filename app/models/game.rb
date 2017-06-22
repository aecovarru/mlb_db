class Game < ApplicationRecord
  belongs_to :game_date
  belongs_to :away_team, class_name: "Team"
  belongs_to :home_team, class_name: "Team"
  has_many :batters, as: :intervalable
  has_many :pitchers, as: :intervalable

  def away_batters
    batters.select {|batter| batter.player.team == away_team}
  end

  def home_batters
    batters.select {|batter| batter.player.team == home_team}
  end

  def away_pitchers
    pitchers.select {|batter| batter.player.team == away_team}
  end

  def home_pitchers
    pitchers.select {|batter| batter.player.team == home_team}
  end
end
