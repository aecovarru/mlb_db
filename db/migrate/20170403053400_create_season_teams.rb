class CreateSeasonTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :season_teams do |t|
      t.belongs_to :season
      t.belongs_to :team
    end
  end
end
