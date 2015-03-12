class Project < ActiveRecord::Base

  has_many :user_to_projects, dependent: :destroy
  has_many :user_project_follows, dependent: :destroy
  has_many :project_to_tags, dependent: :destroy
  has_many :project_tasks, dependent: :destroy
  has_many :positions, dependent: :destroy

  validates :title, :short_description, presence: true
end
