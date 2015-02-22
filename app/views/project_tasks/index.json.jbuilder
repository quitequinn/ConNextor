json.array!(@project_tasks) do |project_task|
  json.extract! project_task, :id, :project_id, :user_id, :name, :description, :state
  json.url project_task_url(project_task, format: :json)
end
