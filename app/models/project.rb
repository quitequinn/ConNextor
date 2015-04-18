class Project < ActiveRecord::Base

  has_many :user_to_projects, dependent: :destroy
  has_many :users, through: :user_to_projects
  has_many :user_project_follows, dependent: :destroy
  has_many :project_to_tags, dependent: :destroy
  has_many :project_tasks, dependent: :destroy
  has_many :positions, dependent: :destroy
  # has_many :project_comments, dependent: :destroy
  has_many :project_posts, dependent: :destroy
  has_many :tasks, dependent: :destroy

  validates :title, :short_description, presence: true

  def self.getProjectOwner( project_id )
    userToProject = UserToProject.find_by_project_id_and_project_user_class(project_id, ProjectUserClass::OWNER)
    if userToProject
      return userToProject.user
    end
  end

  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      where(nil)
    end
  end
end
