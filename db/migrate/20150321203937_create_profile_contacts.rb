class CreateProfileContacts < ActiveRecord::Migration
  def change
    create_table :profile_contacts do |t|
      t.integer :profile_id
      t.string :type
      t.string :name
      t.string :link

      t.timestamps null: false
    end
  end
end
