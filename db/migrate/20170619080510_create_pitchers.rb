class CreatePitchers < ActiveRecord::Migration[5.0]
  def change
    create_table :pitchers do |t|
      t.references :intervalable
      t.string :intervalable_type
      t.references :statable
      t.string :statable_type
      t.boolean :starter, default: false
      t.boolean :bullpen, default: false
    end
  end
end
