class ProjectUserClass < ActiveRecord::Base
  has_many :user_to_projects

  before_destroy :ensure_no_user_is_of_class
  validates :name, uniqueness: true
  validates :name, presence: true

  private
  def ensure_no_user_is_of_class
    if user_to_projects.empty?
      return true
    else
      errors.add(:base, 'Users of class present')
      return false
    end
  end
end
