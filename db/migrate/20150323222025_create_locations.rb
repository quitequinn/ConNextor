class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :country
      t.string :region
      t.string :city

      t.timestamps null: false
    end
  end
end
