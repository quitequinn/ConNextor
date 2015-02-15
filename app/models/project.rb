class Project < ActiveRecord::Base

  has_many :user_to_projects, dependent: :destroy
  has_many :users, through: :user_to_projects

  validates :title, :short_description, presence: true

end
