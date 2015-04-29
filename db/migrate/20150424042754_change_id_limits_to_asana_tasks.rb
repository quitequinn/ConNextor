class ChangeIdLimitsToAsanaTasks < ActiveRecord::Migration
  def change
    change_column :asana_tasks, :workspace_id, :integer, limit: 8
    change_column :asana_tasks, :asana_task_id, :integer, limit: 8
    change_column :asana_tasks, :asana_project_id, :integer, limit: 8
    change_column :asana_tasks, :assigned_to, :integer, limit: 8
  end
end
