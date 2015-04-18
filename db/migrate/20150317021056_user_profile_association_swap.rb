class UserProfileAssociationSwap < ActiveRecord::Migration
  def change
    add_column :users, :profile_id, :integer
    remove_column :profiles, :user_id
  end
end
