json.array!(@requests) do |request|
  json.extract! request, :id, :receiver_id, :sender_id, :request_type, :request_type_id, :message, :link
  json.url request_url(request, format: :json)
end
