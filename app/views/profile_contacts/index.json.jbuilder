json.array!(@profile_contacts) do |profile_contact|
  json.extract! profile_contact, :id, :profile_id, :type, :name, :link
  json.url profile_contact_url(profile_contact, format: :json)
end
