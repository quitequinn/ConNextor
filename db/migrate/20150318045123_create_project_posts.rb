class CreateProjectPosts < ActiveRecord::Migration
  def change
    create_table :project_posts do |t|
      t.belongs_to :user, index: true
      t.belongs_to :project, index: true
      t.string :text

      t.timestamps null: false
    end
    add_foreign_key :project_posts, :users
    add_foreign_key :project_posts, :projects
  end
end
