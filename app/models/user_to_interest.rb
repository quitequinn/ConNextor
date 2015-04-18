class UserToInterest < ActiveRecord::Base
  belongs_to :user
  belongs_to :interest

  validates_uniqueness_of :user_id, scope: :interest_id


end
