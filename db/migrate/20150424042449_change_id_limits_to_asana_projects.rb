class ChangeIdLimitsToAsanaProjects < ActiveRecord::Migration
  def change
    change_column :asana_projects, :asana_project_id, :integer, limit: 8
  end

  def up
    change_column :asana_projects, :workspace_id, :integer, limit: 8
  end

  def down
    change_column :asana_projects, :workspace_id, :string
  end
end
