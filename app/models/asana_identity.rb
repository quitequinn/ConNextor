class AsanaIdentity < ActiveRecord::Base
  belongs_to :user

  def self.find_with_omniauth( auth )
    find_by_provider_and_uid(auth.provider, auth.uid)
  end

  def self.create_with_omniauth(auth, user_id)
    create( user_id: user_id,
            provider: auth.provider,
            uid: auth.uid,
            access_token: auth.credentials.token,
            refresh_token: auth.credentials.refresh_token )
  end
  
end
