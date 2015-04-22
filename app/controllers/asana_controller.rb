class AsanaController < ApplicationController
  def index
  end

  # Creating asana identity
  def create
    auth = env['omniauth.auth']
    @asana_identity = AsanaIdentity.find_with_omniauth(auth)
    AsanaIdentity.create_with_omniauth(auth, current_user_id) if @asana_identity.nil?
    # get new bearer tokens
    redirect_to action:'show', id: session.delete(:return_to)
  end

  # Setting project integration
  def show
    @workspaces = []
    @projects = []
    @project_id = params[:project_id]
    asana_identity = AsanaIdentity.find_by_user_id( current_user_id )
    @asana_project = AsanaProject.find_by_project_id( @project_id  )
    workspace_id = @asana_project.workspace_id if @asana_project
    if asana_identity
      token =  asana_identity.access_token
      @workspaces = JSON.parse workspaces(token)
      @asana_user_id = (JSON.parse current_asana_user(token))['data']['id'] if current_asana_user(token)['data']
    end
  end

  def integrate
    AsanaProject.create( project_id: asana_project_params[:project_id],
                         workspace_id: asana_project_params[:workspace_id],
                         asana_user_id: asana_project_params[:asana_user_id],
                         user_id: current_user_id)

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
