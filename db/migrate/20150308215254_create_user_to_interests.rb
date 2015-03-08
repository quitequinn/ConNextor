class CreateUserToInterests < ActiveRecord::Migration
  def change
    create_table :user_to_interests do |t|
      t.belongs_to :user, index: true
      t.belongs_to :interest, index: true

      t.timestamps null: false
    end
    add_foreign_key :user_to_interests, :users
    add_foreign_key :user_to_interests, :interests
  end
end
