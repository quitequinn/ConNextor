class InvitationCode < ActiveRecord::Base
  has_many :invitation_code_records, dependent: :destroy

  def self.validate(invitation_code)
    code = InvitationCode.find_by_code invitation_code
    if code
      return code.id
    else
      false
    end
  end
end
