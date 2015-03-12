json.array!(@notifications) do |notification|
  json.extract! notification, :id, :receiver_id, :sender_id, :message, :link
  json.url notification_url(notification, format: :json)
end
