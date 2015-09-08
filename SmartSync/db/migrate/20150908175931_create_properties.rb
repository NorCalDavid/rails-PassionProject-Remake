class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
        t.integer :user_id
        t.integer :home_id

      t.timestamps null: false
    end

    add_index :properties, :user_id
    add_index :properties, :home_id
    add_index :properties, [:user_id, :home_id], unique: true

  end
end
