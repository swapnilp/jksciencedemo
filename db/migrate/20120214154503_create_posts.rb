class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :post, :null => false
      t.references :user, :null => false
      t.references :forum, :null => false
      t.integer :post_post_id, :null => true
      t.timestamps
    end
  end
end
