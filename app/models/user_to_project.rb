class UserToProject < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :user, :project, :project_user_class, presence: true
  validates_uniqueness_of :project_id, scope: :user_id
  validates :project_user_class, inclusion: { in: ProjectUserClass::CLASSES }
end
