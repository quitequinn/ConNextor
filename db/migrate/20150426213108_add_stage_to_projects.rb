class AddStageToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :stage, :string
  end
end
