class CreateSolvedtests < ActiveRecord::Migration
  def change
    create_table :solvedtests do |t|
      t.references :batchtest, :null => false
      t.references :user, :null => false
      t.string :questions_id, :null => false
      t.string :questions_answer, :null => false
      t.timestamps
    end
  end
end
