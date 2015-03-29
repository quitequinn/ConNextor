class UserToProject < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates_presence_of :user, :project, :project_user_class
  validates_uniqueness_of :user_id, scope: :project_id
  validates :project_user_class, inclusion: { in: ProjectUserClass::CLASSES }
end
