class AddFieldsToAsanaIdentities < ActiveRecord::Migration
  def change
    add_column :asana_identities, :provider, :string
    add_column :asana_identities, :uid, :string
  end
end
