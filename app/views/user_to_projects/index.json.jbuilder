json.array!(@user_to_projects) do |user_to_project|
  json.extract! user_to_project, :id, :user_id, :project_id, :project_user_class_id
  json.url user_to_project_url(user_to_project, format: :json)
end
