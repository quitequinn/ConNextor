class UserToProject < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :user, :project, :project_user_class, presence: true
  validates_uniqueness_of :user_id, scope: :project_id

  # this is to cause compile errors if used improperly
  def self.user_classes
    {
        'owner' => 'Ownership',
        'core_member' => 'Core Membership',
        'contributor' => 'Contribution'
    }
  end
end
