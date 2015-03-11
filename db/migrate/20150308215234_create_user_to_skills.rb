class CreateUserToSkills < ActiveRecord::Migration
  def change
    create_table :user_to_skills do |t|
      t.belongs_to :user, index: true
      t.belongs_to :skill, index: true

      t.timestamps null: false
    end
    add_foreign_key :user_to_skills, :users
    add_foreign_key :user_to_skills, :skills
  end
end
