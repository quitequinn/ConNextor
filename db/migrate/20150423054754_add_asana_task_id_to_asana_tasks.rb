class AddAsanaTaskIdToAsanaTasks < ActiveRecord::Migration
  def change
    add_column :asana_tasks, :asana_task_id, :integer
  end
end
