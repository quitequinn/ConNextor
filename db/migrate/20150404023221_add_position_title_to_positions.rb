class AddPositionTitleToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :position_title, :string
  end
end
