class ProjectTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  has_many :user_to_project_tasks

  validates :name, :description, :state, :project, :user, presence: true
  validates :state, inclusion: { in: ProjectTaskState::STATES }
end
