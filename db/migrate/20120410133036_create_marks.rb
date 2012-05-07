class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.references :batchtest, :null => false
      t.references :student, :null => false
      t.integer :mark, :null => false      
      t.timestamps
    end
  end
end
