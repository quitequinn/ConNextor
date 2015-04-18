json.array!(@user_follows) do |user_follow|
  json.extract! user_follow, :id, :follower_id, :followee_id
  json.url user_follow_url(user_follow, format: :json)
end
