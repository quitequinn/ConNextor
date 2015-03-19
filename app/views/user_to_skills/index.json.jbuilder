json.array!(@user_to_skills) do |user_to_skill|
  json.extract! user_to_skill, :id, :user_id, :skill_id
  json.url user_to_skill_url(user_to_skill, format: :json)
end
