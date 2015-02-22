json.array!(@user_to_project_tasks) do |user_to_project_task|
  json.extract! user_to_project_task, :id, :user_id, :project_task_id, :relation
  json.url user_to_project_task_url(user_to_project_task, format: :json)
end
