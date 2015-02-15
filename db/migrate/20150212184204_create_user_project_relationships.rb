class CreateUserProjectRelationships < ActiveRecord::Migration
  def change
    create_table :user_project_relationships do |t|
      t.integer :user_id
      t.integer :project_id

      t.timestamps null: false
    end

    add_index :user_project_relationships, :user_id
    add_index :user_project_relationships, :project_id
    add_index :user_project_relationships, [:user_id, :project_id], unique: true
  end
end
