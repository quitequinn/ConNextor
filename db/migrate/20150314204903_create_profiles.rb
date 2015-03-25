class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :location
      t.string :school
      t.string :short_bio

      t.timestamps null: false
    end
  end
end
