class User < ActiveRecord::Base

  has_many :user_to_projects, dependent: :destroy
  has_many :user_project_follows, dependent: :destroy
  has_many :project_tasks
  has_many :identities

  attr_accessor :password
  before_save :downcase_email, :encrypt_password
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :on => :create
  validates_uniqueness_of :email, :on => :create
  before_create { generate_remember_token(:remember_token) }
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_salt && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
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

  def self.create_with_omniauth(auth)
    create(
        :email => auth.info.email,
        :name =>  auth.info.name,
        :username =>  auth.info.nickname,
        :first_name =>  auth.info.first_name,
        :last_name =>  auth.info.last_name,
        :location =>  auth.info.location,
        :image =>  auth.info.image,
        :description => auth.info.description,
        :phone => auth.info.phone
        )
  end

  def downcase_email
    self.email = email.downcase
  end
  
  def generate_remember_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def send_password_reset
    self.update_column(:password_reset_token, SecureRandom.urlsafe_base64)
    self.update_column(:password_reset_sent_at, Time.zone.now)
    UserMailer.send_password_reset_mail(self).deliver
  end

end


