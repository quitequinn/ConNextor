json.array!(@user_project_follows) do |user_project_follow|
  json.extract! user_project_follow, :id, :user_id, :project_id
  json.url user_project_follow_url(user_project_follow, format: :json)
end
