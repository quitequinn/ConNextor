require 'net/https'
require "uri"

class AsanaController < ApplicationController
  def index
  end

  def create
    auth = env['omniauth.auth']
    token = auth.credentials.token
    refresh_token = auth.credentials.refresh_token

    AsanaIdentity.create( user_id: current_user_id,
                          access_token: token,
                          refresh_token: refresh_token)

    redirect_to :action => 'show'
  end

  def show
    AsanaIdentity = AsanaIdentity.find_by_user_id( current_user_id )
    token = AsanaIdentity.access_token
    @result = workspaces(token)
  end

end
