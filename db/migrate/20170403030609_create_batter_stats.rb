class CreateBatterStats < ActiveRecord::Migration[5.0]
  def change
    create_table :batter_stats do |t|

      t.timestamps
    end
  end
end
