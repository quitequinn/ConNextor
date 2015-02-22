class CreateProjectTasks < ActiveRecord::Migration
  def change
    create_table :project_tasks do |t|
      t.integer :project_id
      t.integer :user_id
      t.string :name
      t.string :description
      t.string :state

      t.timestamps null: false
    end
  end
end
