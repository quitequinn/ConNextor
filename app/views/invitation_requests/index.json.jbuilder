json.array!(@invitation_requests) do |invitation_request|
  json.extract! invitation_request, :id, :name, :email, :expertise, :github, :linkedin, :portfolio, :message
  json.url invitation_request_url(invitation_request, format: :json)
end
