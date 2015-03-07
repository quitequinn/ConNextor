class AddConfirmationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :confirmed, :boolean
    add_column :users, :confirm_code, :string
  end
end
