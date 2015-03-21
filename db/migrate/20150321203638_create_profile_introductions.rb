class CreateProfileIntroductions < ActiveRecord::Migration
  def change
    create_table :profile_introductions do |t|
      t.integer :profile_id
      t.string :body

      t.timestamps null: false
    end
  end
end
