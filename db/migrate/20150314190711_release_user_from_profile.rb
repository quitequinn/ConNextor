class ReleaseUserFromProfile < ActiveRecord::Migration
  def up
    # remove_column :users, :first_name
    # remove_column :users, :last_name
    remove_column :users, :location
    remove_column :users, :school
    remove_column :users, :school_email
    remove_column :users, :phone
    remove_column :users, :name
    remove_column :users, :description
    remove_column :users, :industry
  end
  def down
    # add_column :users, :first_name, :string
    # add_column :users, :last_name, :string
    add_column :users, :location, :string
    add_column :users, :school, :string
    add_column :users, :school_email, :string
    add_column :users, :phone, :string
    add_column :users, :name, :string
    add_column :users, :description, :string
    add_column :users, :industry, :string
  end
end
