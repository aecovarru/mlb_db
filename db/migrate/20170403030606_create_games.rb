class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.references :game_date
      t.references :away_team
      t.references :home_team
      t.integer :num
      t.integer :hour
      t.integer :minutes
      t.string :ump
    end
  end
end
