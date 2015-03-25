class ProjectToTag < ActiveRecord::Base
  belongs_to :project
  belongs_to :project_tag

  #validates :project, :project_tag, presence: true
  #validates_uniqueness_of :project_tag_id, scope: :project_id
end
