json.array!(@positions) do |position|
  json.extract! position, :id, :description, :projects_id
  json.url position_url(position, format: :json)
end
