class Pitcher < ApplicationRecord
  belongs_to :statable, polymorphic: true
  belongs_to :intervalable, polymorphic: true
  has_many :pitcher_stats

  def player
    statable if statable_type == "Player"
  end

  def lefty
    pitcher_stats.find_by(stat_type: "L")
  end

  def righty
    pitcher_stats.find_by(stat_type: "R")
  end

  def past
    pitcher_stats.find_by(stat_type: "30")
  end
  
  def both
    pitcher_stats.find_by(stat_type: "B")
  end
end
