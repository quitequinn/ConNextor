class CreateProjectTags < ActiveRecord::Migration
  def change
    create_table :project_tags do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
