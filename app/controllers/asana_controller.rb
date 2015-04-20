class AsanaController < ApplicationController
  def index
  end

  def create
    auth = env['omniauth.auth']
    @asanaIdentity = AsanaIdentity.find_with_omniauth(auth)
    @asanaIdentity = AsanaIdentity.create_with_omniauth(auth, current_user_id) if @asanaIdentity.nil?
    # get new token using refresh token if current token as expired
    redirect_to :action => 'show'
  end

  def show
    asanaIdentity = AsanaIdentity.find_by_user_id( current_user_id )
    token = asanaIdentity.access_token
    @workspaces = JSON.parse workspaces(token)
    @asana_user_id = (JSON.parse current_asana_user(token))['data']['id']
    @projects = current_user.projects
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
