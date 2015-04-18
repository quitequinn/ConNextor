class RenameColumnTypeOfProfileContacts < ActiveRecord::Migration
  def change
    rename_column :profile_contacts, :type, :contact_type
  end
end
