class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.belongs_to :user, index: true
      t.string :activity_type
      t.integer :source_id
      t.integer :parent_id
      t.string :parent_type

      t.timestamps null: false
    end
    add_foreign_key :activities, :users
  end
end
