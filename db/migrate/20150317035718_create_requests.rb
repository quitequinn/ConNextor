class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :receiver_id
      t.integer :sender_id
      t.string :request_type
      t.integer :request_type_id
      t.string :message
      t.string :link
      t.timestamps null: false
    end
  end
end
