class ProjectPost < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :project_comments, dependent: :destroy

  def is_post_owner?(current_user)
    current_user and current_user.id == user_id
  end

end
