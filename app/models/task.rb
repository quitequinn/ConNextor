class Task < ActiveRecord::Base
  belongs_to :project
  has_many :user_to_tasks, dependent: :destroy
  has_many :users, through: :user_to_tasks

  def self.get_created_by_user_name(user_id)
    user = User.find(user_id)
    user.first_name + " " + user.last_name
  end


end