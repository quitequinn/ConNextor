json.array!(@user_to_interests) do |user_to_interest|
  json.extract! user_to_interest, :id, :user_id, :interest_id
  json.url user_to_interest_url(user_to_interest, format: :json)
end
