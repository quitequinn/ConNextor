require "rubygems"
require "json"
require "net/https"
require "asana" # third party package

class AsanaController < ApplicationController
  def index
    ### RESTful API
    api_key = "7ulZlMaK.bFPfOnISthwkX3p5MnWxvpf"
    workspace_id = 22997303805741
    assignee = "oldfatcrab@gmail.com"

    # set up HTTPS connection
    uri = URI.parse("https://app.asana.com/api/1.0/tasks")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # set up the request
    header = {
      "Content-Type" => "application/json"
    }

    req = Net::HTTP::Post.new(uri.path, header)
    req.basic_auth(api_key, '')
    req.body = {
      "data" => {
        "workspace" => workspace_id,
        "name" => "Hello World!",
        "assignee" => assignee
      }
    }.to_json()

    # issue the request
    res = http.start { |http| http.request(req) }

    # output
    @restful = res.body

    #if body['errors'] then
      #puts "Server returned an error: #{body['errors'][0]['message']}"
    #else
      #puts "Created task with id: #{body['data']['id']}"
    #end

    ### Third Party package
    #initialization
    Asana.configure do |client|
      client.api_key = api_key
    end
    @asana = Asana::User.me.to_json()
  end
end
