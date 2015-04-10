class CreateDocComments < ActiveRecord::Migration
  def change
    create_table :doc_comments do |t|
      t.string  :content
      t.integer :user_id
      t.integer :doc_id

      t.timestamps
    end
    add_index :doc_comments, [:user_id, :doc_id, :created_at]
  end
end
