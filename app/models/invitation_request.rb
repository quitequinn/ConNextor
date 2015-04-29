class InvitationRequest < ActiveRecord::Base
  validates_presence_of :name, :email, :message

  mount_uploader :resume, DocUploader

end
