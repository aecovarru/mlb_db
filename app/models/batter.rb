class Batter < ApplicationRecord
  belongs_to :statable, polymorphic: true
  belongs_to :intervalable, polymorphic: true
  has_many :batter_stats

  def player
    statable if statable_type == "Player"
  end

  def lefty
    batter_stats.find_by(stat_type: "L")
  end

  def righty
    batter_stats.find_by(stat_type: "R")
  end

  def past
    batter_stats.find_by(stat_type: "14")
  end
end
