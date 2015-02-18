class DropProjectUserClasses < ActiveRecord::Migration
  def change
    drop_table :project_user_classes
  end
end
