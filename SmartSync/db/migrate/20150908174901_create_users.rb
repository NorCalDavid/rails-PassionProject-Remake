class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :oauth_token
      t.integer :oauth_expires_at
      t.string :picture
      t.string :uid
      t.string :provider

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
  end
end
