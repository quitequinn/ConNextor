json.array!(@profile_experiences) do |profile_experience|
  json.extract! profile_experience, :id, :profile_id, :name, :position, :from_date, :to_date, :description
  json.url profile_experience_url(profile_experience, format: :json)
end
