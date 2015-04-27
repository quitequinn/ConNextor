class InvitationCode < ActiveRecord::Base
  # has_many :invitation_code_records, dependent: :destroy

  def self.validate(invitation_code)
    if InvitationCode.find_by_code invitation_code
      return true
    else
      false
    end
  end
end
