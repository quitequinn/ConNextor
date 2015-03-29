class UserToProjectTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :project_task

  validates :user, :project_task, :relation, presence: true
  validates_uniqueness_of :project_task_id, scope: :user_id
  validates :relation, inclusion: { in: UserTaskRelation::RELATIONS }
end
