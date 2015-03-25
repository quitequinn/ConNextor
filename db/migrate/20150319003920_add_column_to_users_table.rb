class AddColumnToUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :password_login, :boolean
  end
end
