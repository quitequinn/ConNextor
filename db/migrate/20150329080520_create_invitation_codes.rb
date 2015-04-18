class CreateInvitationCodes < ActiveRecord::Migration
  def change
    create_table :invitation_codes do |t|
      t.belongs_to :user, index: true
      t.string :code
      t.boolean :used
      t.timestamps null: false
    end
  end
end
