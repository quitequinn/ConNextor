class CreateAsanaIdentities < ActiveRecord::Migration
  def change
    create_table :asana_identities do |t|
      t.belongs_to :user, index: true
      t.string :access_token
      t.string :refresh_token

      t.timestamps null: false
    end
  end
end
