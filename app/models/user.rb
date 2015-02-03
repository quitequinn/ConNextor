class User < ActiveRecord::Base

  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user == nil
      user = find_by_username(email) #looks for username
    end
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.omniauth(auth)
    if find_by_email(auth.info.email) && !find_by_provider_and_uid(auth.provider,auth.uid)
       user = find_by_email(auth.info.email)
       User.update( user.id, 
                    :provider => auth.provider,
                    :uid => auth.uid,
                    :oauth_token => auth.credentials.token, 
                    :oauth_expires_at => Time.at(auth.credentials.expires_at) )
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.provider = auth.provider 
        user.uid = auth.uid
        user.name = auth.info.name
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        user.save
      end
    end
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end
end


