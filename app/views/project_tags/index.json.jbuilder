json.array!(@project_tags) do |project_tag|
  json.extract! project_tag, :id, :name
  json.url project_tag_url(project_tag, format: :json)
end
