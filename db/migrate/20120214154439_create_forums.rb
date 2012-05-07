class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :description, :null => false
      t.string :title, :null => false
      t.references :topic, :null => false
      t.references :user, :null => false
      t.timestamps
    end
  end
end
