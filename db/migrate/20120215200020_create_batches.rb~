class CreateBatches < ActiveRecord::Migration
  def change
    create_table :batches do |t|
      t.string :description, :null => false
      t.date :start_date, :null => false
      t.date :end_date, :null => false
      t.string :group, :null => false, :default => "pcmb"
      t.string :incharge, :null => false
      t.timestamps
    end
  end
end
