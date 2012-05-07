class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :name, :null => false
      t.string :phone_number, :null => false
      t.string :email, :null => false
      t.timestamps
    end
    Admin.new(:name => "swapnil", :phone_number => "9850840777", :email => "swapnil.patil04@gmail.com").save
  end
end
