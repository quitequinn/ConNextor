class CreateProfileExperiences < ActiveRecord::Migration
  def change
    create_table :profile_experiences do |t|
      t.integer :profile_id
      t.string :name
      t.string :position
      t.string :from_date
      t.string :to_date
      t.string :description

      t.timestamps null: false
    end
  end
end
