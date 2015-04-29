class AddColumnToInvitationRequest < ActiveRecord::Migration
  def change
    add_column :invitation_requests, :resume, :string
  end
end
