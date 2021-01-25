class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.references :project,foreign_key: true
      t.string :title
      t.boolean :completed, default: false
      t.date :due_date
      t.timestamps
    end
  end
end
