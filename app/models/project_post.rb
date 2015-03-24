class ProjectPost < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :project_comments
end
