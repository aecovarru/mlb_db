class CreateBatters < ActiveRecord::Migration[5.0]
  def change
    create_table :batters do |t|
      t.references :intervalable
      t.string :intervalable_type
      t.references :statable
      t.string :statable_type
      t.string :position
      t.string :lineup
      t.boolean :starter, default: false
    end
  end
end
