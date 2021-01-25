class Comments < ActiveRecord::Migration[6.1]
  def change
  
      create_table :comments do |t|
        t.string :body
        t.timestamps
        t.references :discussion, foreign_key: true
      end

  end
end
