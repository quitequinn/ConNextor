class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :feedback
      t.decimal :rating
      t.integer :feedback_creator
      t.belongs_to :user_to_task, index: true
    end
    add_foreign_key :feedbacks, :user_to_tasks
  end
end