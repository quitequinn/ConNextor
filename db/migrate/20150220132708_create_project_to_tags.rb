class CreateProjectToTags < ActiveRecord::Migration
  def change
    create_table :project_to_tags do |t|
      t.integer :project_id
      t.integer :project_tag_id

      t.timestamps null: false
    end
  end
end
