class CreateProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :properties do |t|
      t.integer :user_id
      t.integer :favorite1
      t.integer :favorite2
    end
  end
end
