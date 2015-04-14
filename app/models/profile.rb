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

  def current_step
    @current_step || steps.first
  end

  def steps
    %w[first second third fourth]
    # %w[first second fourth]
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

end
