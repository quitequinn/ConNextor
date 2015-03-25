class CreateUserFollows < ActiveRecord::Migration
  def change
    create_table :user_follows do |t|
      t.integer :follower_id
      t.integer :followee_id

      t.timestamps null: false
    end
  end
end
