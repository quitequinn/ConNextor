class Profile < ActiveRecord::Base

  has_one :user
  has_one :profile_introduction, dependent: :destroy
  has_many :profile_experiences, -> { order(created_at: :asc) }, dependent: :destroy
  has_many :profile_educations, -> { order(created_at: :asc) }, dependent: :destroy
  has_many :profile_contacts, -> { order(created_at: :asc) }, dependent: :destroy

  accepts_nested_attributes_for :user
  attr_accessor :has_idea
  attr_accessor :code
  attr_accessor :first_name
  attr_accessor :last_name

  mount_uploader :resume, DocUploader
  mount_uploader :profile_photo, ImageUploader
  mount_uploader :cover_photo, ImageUploader

  ##########Registration############

  def self.update_user_info( user, profile_params )
    if profile_params[:first_name]
      user.update( first_name: profile_params[:first_name] )
    end
    if profile_params[:last_name]
      user.update( last_name: profile_params[:last_name] )
    end
  end

  def self.file_step_hash
    %w[
      profiles/registration_basic_information
      profiles/registration_geographic
      profiles/registration_interests
      profiles/registration_skills
      profiles/registration_wrap_up
    ]
  end
end
