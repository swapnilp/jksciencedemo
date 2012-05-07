class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name, :null => false
      t.string :phone_number, :null => false
      t.string :address, :null => false
      t.references :subject, :null => false
      t.string :email, :null => false
      t.timestamps
    end
  end
end
