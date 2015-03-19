json.array!(@activities) do |activity|
  json.extract! activity, :id, :user_id, :activity_type, :source_id, :parent_id, :parent_type
  json.url activity_url(activity, format: :json)
end
