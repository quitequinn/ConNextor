class ProjectTag < ActiveRecord::Base
  has_many :project_to_tags, dependent: :destroy

  validates :name, presence: true
end
