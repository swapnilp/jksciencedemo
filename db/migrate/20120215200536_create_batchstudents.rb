class CreateBatchstudents < ActiveRecord::Migration
  def change
    create_table :batchstudents do |t|
      t.references :batch, :null => false
      t.references :student, :null => false
      t.string :report, :null => false, :default => "average"
      t.timestamps
    end
  end
end
