class CreateDiscussions < ActiveRecord::Migration[6.1]
  def change
    create_table :discussions do |t|
      t.string :title
      t.string :body

      t.timestamps
      t.references :project, foreign_key: true
    end
  end
end
