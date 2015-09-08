class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :name
      t.string :description
      t.integer :code
      t.string :status
      t.integer :room_id

      t.timestamps null: false
    end
  end
end
