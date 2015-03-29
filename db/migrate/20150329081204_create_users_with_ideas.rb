class CreateUsersWithIdeas < ActiveRecord::Migration
  def change
    create_table :users_with_ideas do |t|
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
