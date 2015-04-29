class AddMemberTypeToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :member_type, :string
  end
end
