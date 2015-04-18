class CreateProfileIdeas < ActiveRecord::Migration
  def change
    create_table :profile_ideas do |t|
      t.belongs_to :user, index: true
    end
  end
end
