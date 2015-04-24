class AsanaTask < ActiveRecord::Base
  belongs_to :asana_project

  def self.create_asana_task( data, asana_project_id )
    assignee = data['assignee']['id'] if data['assignee']
    workspace_id = data['workspace']['id'] if data['workspace']
    create( asana_task_id: data['id'],
            title: data['name'],
            description: data['notes'],
            #due_on: data['due_on'],
            #modified_at: data['modified_at'],
            completed: data['completed'],
            assigned_to: assignee,
            workspace_id: workspace_id,
            asana_project_id: asana_project_id 
          )
  end

  def update_asana_task( data, asana_project_id )
    assignee = data['assignee']['id'] if data['assignee']
    workspace_id = data['workspace']['id'] if data['workspace']
    update( title: data['name'],
            description: data['notes'],
            #due_on: data['due_on'],
            #modified_at: data['modified_at'],
            completed: data['completed'],
            assigned_to: assignee,
            workspace_id: workspace_id,
            asana_project_id: asana_project_id 
          )
  end
end