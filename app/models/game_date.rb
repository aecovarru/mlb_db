class GameDate < ApplicationRecord
  belongs_to :season
  has_many :games, dependent: :destroy

  class << self
    def test
      self.find_by_date(Date.new(2016,6,1))
    end
    def yesterday
      self.find_or_create_by(date: Date.yesterday, season: Season.find_by_year(Date.yesterday.year)) 
    end
    def today
      self.find_or_create_by(date: Date.today, season: Season.find_by_year(Date.today.year)) 
    end
    def tomorrow
      self.find_or_create_by(date: Date.tomorrow, season: Season.find_by_year(Date.tomorrow.year)) 
    end
  end

  def year
    date.year
  end
  
  def month
    date.month
  end

  def day
    date.day
  end
  
end
