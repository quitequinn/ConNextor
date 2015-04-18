class Task < ActiveRecord::Base
  belongs_to :project
  has_many :user_to_tasks, dependent: :destroy
  has_many :users, through: :user_to_tasks
end