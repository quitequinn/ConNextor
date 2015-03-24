class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.belongs_to :user, index: true
      t.string :notification_type
      t.integer :actor_id
      t.string :message
      t.string :link
      t.string :verb
      t.boolean :isRead
    end
  end
end
