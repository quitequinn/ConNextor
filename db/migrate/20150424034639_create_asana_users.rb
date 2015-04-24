class CreateAsanaUsers < ActiveRecord::Migration
  def change
    create_table :asana_users do |t|
      t.integer :user_id
      t.integer :asana_user_id
      t.timestamps null: false
    end
  end
end
