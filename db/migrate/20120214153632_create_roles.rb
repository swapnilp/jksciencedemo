class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, :null => false
      t.timestamps
    end
    Role.new(:name => 'Admin').save
    Role.new(:name => 'teacher').save
    Role.new(:name => 'student').save
  end
end
