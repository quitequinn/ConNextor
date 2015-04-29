class AddUserIdToAsanaProjects < ActiveRecord::Migration
  def change
    add_column :asana_projects, :user_id, :integer
  end
end
