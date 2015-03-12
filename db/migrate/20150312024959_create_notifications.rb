class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :receiver_id
      t.integer :sender_id
      t.string :message
      t.string :link

      t.timestamps null: false
    end
  end
end
