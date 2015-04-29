class CreateAsanaTasks < ActiveRecord::Migration
  def change
    create_table :asana_tasks do |t|
      t.belongs_to :asana_project, index: true
      t.integer :created_by
      t.integer :assigned_to
      t.integer :workspace_id
      t.boolean :completed
      t.datetime :completed_at
      t.string :description
      t.string :title
    end
  end
end
