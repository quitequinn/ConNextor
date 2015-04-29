class Feedback < ActiveRecord::Base
  belongs_to :user_to_task
end