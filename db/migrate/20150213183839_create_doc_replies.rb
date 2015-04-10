class CreateDocReplies < ActiveRecord::Migration
  def change
    create_table :doc_replies do |t|
      t.string :content
      t.integer :user_id
      t.integer :doc_comment_id

      t.timestamps null: false
    end
    add_index :doc_replies, [:user_id, :doc_comment_id, :created_at]
  end
end