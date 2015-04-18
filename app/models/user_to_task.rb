class UserToTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  validates_uniqueness_of :task_id, scope: :user_id
  validates :status, inclusion: { in: UserTaskStatus::STATUSES }
end