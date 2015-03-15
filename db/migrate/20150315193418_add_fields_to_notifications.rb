class AddFieldsToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :project_id, :integer
    add_column :notifications, :position_id, :integer
  end
end
