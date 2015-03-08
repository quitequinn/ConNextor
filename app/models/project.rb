class Project < ActiveRecord::Base
  has_many :user_to_projects, dependent: :destroy
  has_many :user_project_follows, dependent: :destroy
  has_many :project_to_tags, dependent: :destroy
  has_many :project_tasks, dependent: :destroy

  validates :title, :short_description, presence: true

  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
