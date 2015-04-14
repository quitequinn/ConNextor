class Skill < ActiveRecord::Base
  has_many :user_to_skills, dependent: :destroy
end
