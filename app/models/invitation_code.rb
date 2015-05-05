class InvitationCode < ActiveRecord::Base
  has_many :invitation_code_records, dependent: :destroy

  def self.validate(invitation_code)
    code = InvitationCode.find_by_code invitation_code
    code_lower = InvitationCode.find_by_code invitation_code.upcase
    if code
      return code.id
    elsif code_lower
      return code_lower.id
    else
      false
    end   
  end
end
