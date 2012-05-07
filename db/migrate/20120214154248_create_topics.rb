class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.references :chapter, :null => false
      t.references :user, :null => false
      t.string :name, :null => false
      t.integer :priority, :null => false, :default => 2
      t.timestamps
    end
  end
end
