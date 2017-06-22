class CreateBatterStats < ActiveRecord::Migration[5.0]
  def change
    create_table :batter_stats do |t|
      t.references :batter
      t.string :stat_type
      t.integer :woba, default: 0
      t.integer :ops, default: 0
      t.integer :ab, default: 0
      t.integer :so, default: 0
      t.integer :bb, default: 0
      t.integer :sb, default: 0
      t.integer :obp, default: 0
      t.integer :slg, default: 0
      t.integer :wrc, default: 0
      t.float :fb, default: 0.0
      t.float :gb, default: 0.0
      t.float :ld, default: 0.0
    end
  end
end
