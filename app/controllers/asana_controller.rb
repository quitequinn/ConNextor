require 'net/https'
require "uri"

class AsanaController < ApplicationController
  def index
    @asana_project = AsanaProject.find_by_user_id( current_user_id )
    @asana_identity = AsanaIdentity.find_by_user_id( current_user_id )
    workspace_id = @asana_project.workspace_id
    asana_user_id = @asana_project.asana_user_id
    token = @asana_identity.access_token

    @projects = JSON.parse workspace_projects( workspace_id, token )

    if @projects
      @tasks = JSON.parse project_tasks( @projects['data'][0]['id'] , token )
    end

    #poll all tasks that have been created within the past 15 minutes
    #poll all tasks that have been completed within the past 15 minutes
    #poll all tasks that have been modified within the past 15 minutes

    #send notification

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
    AsanaProject.create( project_id: asanaProject_params[:project_id],
                         workspace_id: asanaProject_params[:workspace_id],
                         asana_user_id: asanaProject_params[:asana_user_id],
                         user_id: current_user_id)

    redirect_to action: 'index'
  end

  private 

    def asanaProject_params
      params.require(:asana_project).permit(
        :workspace_id,
        :asana_user_id,
        :project_id)
    end

    def make_asana_request(url, token)
      uri = URI.parse( url )
      http = Net::HTTP.new( uri.host, uri.port )
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(uri.request_uri)
      request.initialize_http_header({"Authorization" => "Bearer #{token}"})
      response = http.request(request)

      # I believe this displays non UTF-8 characters
      result = response.body.force_encoding('ISO-8859-1')
    end

    def workspaces( token )
      url = ASANA::API_URL + "/workspaces"
      make_asana_request( url, token )
    end

    def workspace_projects( workspace_id, token )
      url = ASANA::API_URL + "/workspaces/#{workspace_id}/projects"
      make_asana_request( url, token )
    end

    def project( project_id, token )
      url = ASANA::API_URL + "/projects/#{project_id}"
      make_asana_request( url, token )
    end

    def workspace_users( workspace_id, token )
      url = ASANA::API_URL + "/workspaces/#{workspace_id}/users"
      make_asana_request( url, token )
    end

    def current_asana_user( token )
      url = ASANA::API_URL + "/users/me"
      make_asana_request( url, token )
    end

    def task( task_id, token )
      url = ASANA::API_URL + "/tasks/#{task_id}"
      make_asana_request( url, token )
    end

    def project_tasks( project_id, token )
      url = ASANA::API_URL + "/projects/#{project_id}/tasks"
      make_asana_request( url, token )
    end

    def workspace_tasks( workspace_id, token )
      url = ASANA::API_URL + "/workspaces/#{workspace_id}/tasks"
      make_asana_request( url, token )
    end

    def tag( tag_id, token )
      url = ASANA::API_URL + "/tags/#{tag_id}"
      make_asana_request( url, token )
    end

    def tag_tasks (tag_id, token )
      url = ASANA::API_URL + "/tags/#{tag_id}/tasks"
      make_asana_request( url, token )
    end

    def workspace_tags( workspace_id, token )
      url = ASANA::API_URL + "/workspaces/#{workspace_id}/tags"
      make_asana_request( url, token )
    end

end
