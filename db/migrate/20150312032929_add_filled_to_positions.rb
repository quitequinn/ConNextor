class AddFilledToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :filled, :boolean
  end
end
