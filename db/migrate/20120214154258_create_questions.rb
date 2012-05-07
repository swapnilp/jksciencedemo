class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :user, :null => false
      t.references :topic, :null => false
      t.string :question, :null => false
      t.string :option_a, :null => false
      t.string :option_b, :null => false
      t.string :option_c, :null => false
      t.string :option_d, :null => false
      t.string :answer, :null => false
      t.timestamps
    end
  end
end
