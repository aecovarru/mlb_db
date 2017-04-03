class CreatePitcherStats < ActiveRecord::Migration[5.0]
  def change
    create_table :pitcher_stats do |t|

      t.timestamps
    end
  end
end
