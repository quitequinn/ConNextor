class ChangeAsanaUserIdFormatInAsanaProjects < ActiveRecord::Migration
  def up
    change_column :asana_projects, :asana_user_id, :integer, :limit => 8
  end

  def down
    change_column :asana_projects, :asana_user_id, :integer
  end
  
end
