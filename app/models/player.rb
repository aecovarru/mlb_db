class Player < ApplicationRecord
  belongs_to :season
  belongs_to :team
end
