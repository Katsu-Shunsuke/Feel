class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :option1
      t.integer :option2
      t.integer :option3
    end
  end
end
