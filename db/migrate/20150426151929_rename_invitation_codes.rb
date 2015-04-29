class RenameInvitationCodes < ActiveRecord::Migration
  def up
    remove_column :invitation_codes, :user_id
    remove_column :invitation_codes, :used
  end

  def down
    change_table :invitation_codes do |t|
      t.belongs_to :user, index: true
      t.boolean :used
    end
  end
end
