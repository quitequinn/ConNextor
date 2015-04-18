class CreateProfileEducations < ActiveRecord::Migration
  def change
    create_table :profile_educations do |t|
      t.string :school
      t.string :major
      t.integer :from_date
      t.integer :to_date
      t.string :description
      t.belongs_to :profile, index: true
      t.timestamps null: false
    end
  end
end
