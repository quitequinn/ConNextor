class CreateInvitationRequests < ActiveRecord::Migration
  def change
    create_table :invitation_requests do |t|
      t.string :name
      t.string :email
      t.string :expertise
      t.string :github
      t.string :linkedin
      t.string :portfolio
      t.string :message

      t.timestamps null: false
    end
  end
end
