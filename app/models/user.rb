class User < ActiveRecord::Base

  belongs_to :profile

  has_one :invitation_code_record, dependent: :destroy

  has_many :user_to_projects, dependent: :destroy
  has_many :user_project_follows, dependent: :destroy
  has_many :projects, through: :user_to_projects
  # has_many :project_tasks, dependent: :destroy
  has_many :identities, dependent: :destroy
  has_many :user_to_interests, dependent: :destroy
  has_many :user_to_skills, dependent: :destroy
  has_many :interests, through: :user_to_interests
  has_many :skills, through: :user_to_skills
  has_many :notifications, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :project_posts, dependent: :destroy
  has_many :project_comments, dependent: :destroy
  has_many :user_to_tasks, dependent: :destroy
  has_many :tasks, through: :user_to_tasks

  attr_accessor :password
  attr_writer :current_step
  before_save :downcase_email, :encrypt_password
  validates_length_of :first_name, maximum: 30
  validates_length_of :last_name, maximum: 30
  validates_presence_of :email
  validates_uniqueness_of :email
  # validates_presence_of :username
  validates_uniqueness_of :username, allow_blank: true
  #validates_format_of :username, with: /\A[a-z0-9]+[-a-z0-9]*[a-z0-9]+\z/i, allow_blank: true,
                      #message: 'only alphanumeric characters and dashes, '

  with_options if: :password_login_is_enabled do |password_login_user|
    password_login_user.validates_presence_of :password_hash, on: :save
    password_login_user.validates_presence_of :password, on: :create
  end

  with_options if: :password_is_present do |password_login_user|
    #password_login_user.validates_presence_of :password_confirmation
    #password_login_user.validates_confirmation_of :password
    password_login_user.validates_length_of :password, minimum: 8
  end


  # validates_presence_of :first_name, :last_name
  before_create { generate_remember_token(:remember_token) }

  def password_login_is_enabled
    self.password_login?
  end

  def password_is_present
    self.password and not self.password.empty?
  end

  def self.search(search)
    if search
      where('first_name LIKE ? OR last_name LIKE ?', "%#{search}%", "%#{search}%")
    else
      self
    end
  end
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user and user.password_login and user.password_salt and user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
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

  def update_with_omniauth(auth)

    unless self.profile
      self.profile = Profile.new
    end

    logger.error self.profile

    case auth.provider
      when 'facebook'
        self.first_name = auth.info.first_name unless self.first_name
        self.last_name = auth.info.last_name unless self.last_name
        self.username = auth.info.nickname unless self.username
        self.email = auth.info.email unless self.email
        self.image = auth.info.image unless self.image

        self.profile.location = auth.info.location unless self.profile.location

        self.profile.facebook_url = auth.info.urls.Facebook
      # when 'twitter'
      #   name_array = auth.info.name.gsub(/\s+/m, ' ').strip.split(' ')

      #   self.first_name = name_array.first unless self.first_name
      #   self.last_name = name_array.last unless self.last_name
      #   self.username = auth.info.nickname unless self.username
      #   # self.email = auth.info.email unless self.email
      #   self.image = auth.info.image unless self.image

      #   self.profile.location = auth.info.location unless self.profile.location
      #   self.profile.short_bio = auth.info.description unless self.profile.short_bio

      #   self.profile.twitter_url = auth.info.urls.Twitter
      when 'linkedin'
        self.first_name = auth.info.first_name unless self.first_name
        self.last_name = auth.info.last_name unless self.last_name
        self.username = auth.info.nickname unless self.username
        self.email = auth.info.email unless self.email
        self.image = auth.info.image unless self.image

        self.profile.location = auth.info.location unless self.profile.location
        self.profile.short_bio = auth.info.description unless self.profile.short_bio

        self.profile.linkedin_url = auth.info.urls.public_profile
      # add more here
    end

    logger.error self.profile.location
    logger.error self.profile.short_bio
    logger.error self.profile.twitter_url
    self.profile = Profile.create(self.profile.attributes)
    logger.error self.profile.id
    # self.profile.save # shouldn't have errors

  end


  def downcase_email
    self.email = email.downcase
  end

  def downcase_username
    self.username = username.downcase
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

  # def create_skills(skill_ids)
  #   if skill_ids
  #     unless skill_ids.length == 1
  #       skill_ids.shift
  #       skills = Skill.find skill_ids
  #       skills.each do |skill|
  #         UserToSkill.create user: self, skill: skill
  #       end
  #     end
  #   end
  # end

  def create_interests(interest_ids)
    if interest_ids
      unless interest_ids.length == 1
        interest_ids.shift
        interests = Interest.find interest_ids
        interests.each do |interest|
          UserToInterest.create user: self, interest: interest
        end
      end
    end
  end

  def update_name(first_name, last_name)
    if first_name and not first_name.empty?
      self.first_name = first_name
    end
    if last_name and not last_name.empty?
      self.last_name = last_name
    end
    self.save
  end

  def self.subscribe_to_mailchimp(email)
    @list_id = ENV["MAILCHIMP_LIST_ID"]
    gb = Gibbon::API.new

    gb.lists.subscribe({
      id: @list_id,
      email: {email: email}
      })
  end

  private

  # def password_and_password_login
  #   if password_login
  #     if password.blank?
  #       errors.add :password, 'Enter a password'
  #     elsif password != password_confirmation
  #
  #     end
  #   end
  # end
  #
  # def password_passes
  #   if self.password_login
  #     validates_presence_of :password_hash, :password_salt
  #   end
  #
  #   if self.password
  #     validates_presence_of :password_confirmation
  #     validates_confirmation_of :password
  #     validates_length_of :password, minimum: 8
  #     validates_exclusion_of :password, in: [record.username, record.first_name],
  #                            message: 'should not be the same as your username or first name'
  #   end
  # end

end


