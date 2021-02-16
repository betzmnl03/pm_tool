class Add < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :assignee, :string
  end
end
