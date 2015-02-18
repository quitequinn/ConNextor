class RenameUserToProjectUserClassColumn < ActiveRecord::Migration
  def change
    rename_column :user_to_projects, :project_user_class_id, :project_user_class
  end
end
