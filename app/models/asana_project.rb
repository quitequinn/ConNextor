class AsanaProject < ActiveRecord::Base
  belongs_to :project
  has_many :asana_tasks, dependent: :destroy

  def self.create_asana_project( data, project_id, user_id )
    workspace_id = data['workspace']['id'] if data['workspace']
    create( user_id: user_id,
            project_id: project_id,
            workspace_id: workspace_id,
            asana_project_id: data['id']
          )
  end

end
