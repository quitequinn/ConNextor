json.array!(@project_user_classes) do |project_user_class|
  json.extract! project_user_class, :id, :name
  json.url project_user_class_url(project_user_class, format: :json)
end
