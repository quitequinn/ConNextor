class InvitationCode < ActiveRecord::Base
  has_many :invitation_code_records
end
