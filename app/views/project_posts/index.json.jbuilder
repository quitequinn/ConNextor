json.array!(@project_posts) do |project_post|
  json.extract! project_post, :id, :user_id, :project_id, :text
  json.url project_post_url(project_post, format: :json)
end
