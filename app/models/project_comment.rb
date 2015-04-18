class ProjectComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :project_post

  def is_comment_owner?(current_user)
    current_user and current_user.id == user_id
  end
end
