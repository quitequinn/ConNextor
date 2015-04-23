class AsanaTask < ActiveRecord::Base
  belongs_to :asana_project

  def self.create_from_Asana(data)
    assignee = data['assignee']['id'] if data['assignee']
    workspace_id = data['workspace']['id'] if data['workspace']
    create( asana_task_id: data['id'],
            title: data['name'],
            description: data['notes'],
            due_on: data['due_on'],
            modified_at: data['modified_at'],
            completed: data['completed'],
            assigned_to: assignee,
            workspace_id: workspace_id
          )
  end
end