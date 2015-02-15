json.array!(@projects) do |project|
  json.extract! project, :id, :title, :short_description, :long_description
  json.url project_url(project, format: :json)
end
