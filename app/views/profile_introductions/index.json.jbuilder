json.array!(@profile_introductions) do |profile_introduction|
  json.extract! profile_introduction, :id, :profile_id, :body
  json.url profile_introduction_url(profile_introduction, format: :json)
end
