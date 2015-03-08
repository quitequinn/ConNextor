json.array!(@interests) do |interest|
  json.extract! interest, :id, :name
  json.url interest_url(interest, format: :json)
end
