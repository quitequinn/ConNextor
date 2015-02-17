class Project < ActiveRecord::Base

  has_many :user_to_projects, dependent: :destroy
  # has_many :users, through: :user_to_projects

  has_many :user_project_follows, dependent: :destroy
  # has_many :users, through: :user_project_follows

  validates :title, :short_description, presence: true

end
