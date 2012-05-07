class CreateTestattempts < ActiveRecord::Migration
  def change
    create_table :testattempts do |t|
      t.references :batchtest, :null => false
      t.references :student, :null => false
      t.timestamps
    end
  end
end
