class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.string :password_digest
      t.string :token
      t.integer :expires
      t.string :picture
      t.string :jwt

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
  end
end
