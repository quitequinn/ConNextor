class AddFieldsToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :position_type, :string
    add_reference :positions, :user, index: true
    add_foreign_key :positions, :users
  end
end
