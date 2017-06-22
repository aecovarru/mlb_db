class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.references :season
      t.references :team
      t.string :name
      t.string :identity
      t.integer :fangraph_id
      t.string :bathand
      t.string :throwhand
    end
  end
end
