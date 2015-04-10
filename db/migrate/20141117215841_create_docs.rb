class CreateDocs < ActiveRecord::Migration
  def change
    create_table :docs do |t|
      t.string :title
      t.integer :user_id
      t.string :topic
      t.string :license
      t.string :description
      t.timestamps
    end
  end
end

