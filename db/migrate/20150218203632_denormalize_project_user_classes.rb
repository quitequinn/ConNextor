class DenormalizeProjectUserClasses < ActiveRecord::Migration
  def change
    change_column :user_to_projects, :project_user_class_id, :text
  end
end
