class InvitationCode < ActiveRecord::Base
  has_many :invitation_code_records, dependent: :destroy
end
