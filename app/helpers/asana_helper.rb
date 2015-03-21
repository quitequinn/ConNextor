module AsanaHelper

  API_HEAD = 'https://app.asana.com/api/1.0'

  def make_request(url, token)
    uri = URI.parse( url )
    http = Net::HTTP.new( uri.host, uri.port )
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    request.initialize_http_header({"Authorization" => "Bearer #{token}"})
    response = http.request(request)
    result = response.body.force_encoding('ISO-8859-1')
    result.to_json
  end

  def workspaces( token )
    url = '#{API_HEAD}/workspaces'
    make_request( url, token )
  end

  def workspace_projects( workspace_id, token )
    url = '#{API_HEAD}/workspaces/#{workspace_id}/projects'
    make_request( url, token )
  end

  def project( project_id, token )
    url = '#{API_HEAD}/projects/#{project_id}'
    make_request( url, token )
  end

  def workspace_users( workspace_id, token )
    url = '#{API_HEAD}/workspaces/#{workspace_id}/users'
    make_request( url, token )
  end

  def current_asana_user( token )
    url = '#{API_HEAD}/users/me'
    make_request( url, token )
  end

  def task( task_id, token )
    url = '#{API_HEAD}/tasks/#{task_id}'
    make_request( url, token )
  end

  def project_tasks( project_id, token )
    url = '#{API_HEAD}/projects/#{project_id}/tasks'
    make_request( url, token )
  end

  def workspace_tasks( workspace_id, token )
    url = '#{API_HEAD}/workspaces/#{workspace_id}/tasks'
    make_request( url, token )
  end

  def tag( tag_id, token )
    url = '#{API_HEAD}/tags/#{tag_id}'
    make_request( url, token )
  end

  def tag_tasks (tag_id, token )
    url = '#{API_HEAD}/tags/#{tag_id}/tasks'
    make_request( url, token )
  end

  def workspace_tags( workspace_id, token )
    url = '#{API_HEAD}/workspaces/#{workspace_id}/tags'
    make_request( url, token )
  end

end
