class CreateUserToProjectTasks < ActiveRecord::Migration
  def change
    create_table :user_to_project_tasks do |t|
      t.integer :user_id
      t.integer :project_task_id
      t.string :relation

      t.timestamps null: false
    end
  end
end
