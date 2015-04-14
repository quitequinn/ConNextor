class Interest < ActiveRecord::Base
  has_many :user_to_interests, dependent: :destroy
end
