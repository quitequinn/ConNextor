class AddRegistrationFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :school, :string
    add_column :users, :school_email, :string
    add_column :users, :industry, :string
  end
end
