class ChangeIdLimitsToAsanaUsers < ActiveRecord::Migration
  def change
    change_column :asana_users, :asana_user_id, :integer, limit: 8
  end
end
