class Identity < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :provider, :uid
  validates_uniqueness_of :uid, scope: :provider

  def self.find_with_omniauth(auth)
    find_by_provider_and_uid(auth.provider, auth.uid)
  end

  # TODO update more fields
  def self.create_with_omniauth(auth)
    if auth.provider == "facebook"
      create( :provider  =>     auth.provider,
              :uid =>           auth.uid,
              :oauth_token =>   auth.credentials.token,
              :oauth_expires_at => auth.credentials.expires_at 
            )
    elsif auth.provider == "twitter"
      create( :provider  =>     auth.provider,
              :uid =>           auth.uid,
              :oauth_token =>   auth.credentials.token
            )
    elsif auth.provider == "linkedin"
      create( :provider  =>     auth.provider,
              :uid =>           auth.uid,
              :oauth_token =>   auth.credentials.token
            )
    end
  end
end
