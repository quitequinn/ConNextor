class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :description
      t.belongs_to :projects, index: true

      t.timestamps null: false
    end
    add_foreign_key :positions, :projects
  end
end
