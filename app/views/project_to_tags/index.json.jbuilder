json.array!(@project_to_tags) do |project_to_tag|
  json.extract! project_to_tag, :id, :project_id, :project_tag_id
  json.url project_to_tag_url(project_to_tag, format: :json)
end
