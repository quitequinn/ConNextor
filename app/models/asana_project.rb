class AsanaProject < ActiveRecord::Base
  belongs_to :project
  has_many :asana_tasks, dependent: :destroy
end
