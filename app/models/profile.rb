class Profile < ActiveRecord::Base
  has_one :user
  has_one :profile_introduction
  has_many :profile_experiences, -> { order(created_at: :asc) }
  has_many :profile_educations, -> { order(created_at: :asc) }
  has_many :profile_contacts, -> { order(created_at: :asc) }

  accepts_nested_attributes_for :user
  attr_accessor :has_idea
  attr_accessor :code

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
