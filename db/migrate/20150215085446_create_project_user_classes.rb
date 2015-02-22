class CreateProjectUserClasses < ActiveRecord::Migration
  def change
    create_table :project_user_classes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
