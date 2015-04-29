class CreateUserToTasks < ActiveRecord::Migration
  def change
    create_table :user_to_tasks do |t|
      t.belongs_to :user, index: true
      t.belongs_to :task, index: true
      t.integer :rating
      t.string :status
      t.boolean :approved
    end
    add_foreign_key :user_to_tasks, :users
    add_foreign_key :user_to_tasks, :tasks
  end
end
