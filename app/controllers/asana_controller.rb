class AsanaController < ApplicationController
  def index
  end

  # Creating asana identity
  def create
    auth = env['omniauth.auth']
    @asana_identity = AsanaIdentity.find_with_omniauth(auth)
    AsanaIdentity.create_with_omniauth(auth, current_user_id) if @asana_identity.nil?
    # TODO get new bearer tokens
    redirect_to action:'show', id: session.delete(:return_to)
  end

  # Setting project integration
  def show
    @workspaces = []
    @projects = []
    @project_id = params[:project_id]
    asana_identity = AsanaIdentity.find_by_user_id( current_user_id )
    
    if asana_identity
      token =  asana_identity.access_token
      @workspaces = JSON.parse workspaces(token)
    end

    # showing existing integration if any
    @asana_project = AsanaProject.find_by_project_id( @project_id  )
    workspace_id = @asana_project.workspace_id if @asana_project
  end

  # Create asana projects
  # maps asana user_id to connextor user_id
  def integrate
    asana_identity = AsanaIdentity.find_by_user_id( current_user_id )
    if asana_identity
      workspace_id = asana_project_params[:workspace_id]
      token =  asana_identity.access_token
      asana_projects = JSON.parse workspace_projects(workspace_id, token)
      asana_projects['data'].each do |asana_project|
        AsanaProject.create( project_id: asana_project_params[:project_id],
                             asana_project_id: asana_project['id'],
                             workspace_id: workspace_id,
                             user_id: current_user_id)
      end
      
      if current_asana_user(token)['data']
        asana_user_id = (JSON.parse current_asana_user(token))['data']['id']
        if AsanaUser.find_by_user_id_and_asana_user_id(current_user_id, asana_user_id ) == nil
          AsanaUser.create( user_id: current_user_id, 
                            asana_user_id: asana_user_id )
        end
      end
    end
    redirect_to Project.find(asana_project_params[:project_id]), notice: 'Successfully Integrated!'
  end

  private 

    def asana_project_params
      params.require(:asana_project).permit(
        :workspace_id,
        :asana_user_id,
        :project_id)
    end

end
