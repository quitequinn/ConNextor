class CreateProjectComments < ActiveRecord::Migration
  def change
    create_table :project_comments do |t|
      t.belongs_to :user, index: true
      t.belongs_to :project_post, index: true
      t.string :text

      t.timestamps null: false
    end
    add_foreign_key :project_comments, :users
    add_foreign_key :project_comments, :project_posts
  end
end
