class UserToProject < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :project_user_class

  validates :user, :project, :project_user_class, presence: true
  validates_uniqueness_of :user_id, scope: :project_id
end
