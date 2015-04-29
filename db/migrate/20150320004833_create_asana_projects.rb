class CreateAsanaProjects < ActiveRecord::Migration
  def change
    create_table :asana_projects do |t|
      t.belongs_to :project, index: true
      t.integer :asana_project_id
      t.string :workspace_id
      t.integer :asana_user_id

      t.timestamps null: false
    end
  end
end
