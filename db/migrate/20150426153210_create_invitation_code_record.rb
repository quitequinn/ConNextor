class CreateInvitationCodeRecord < ActiveRecord::Migration
  def change
    create_table :invitation_code_records do |t|
      t.belongs_to :user, index: true
      t.belongs_to :invitation_code, index: true
    end
    add_foreign_key :invitation_code_records, :users
    add_foreign_key :invitation_code_records, :invitation_codes
  end
end
