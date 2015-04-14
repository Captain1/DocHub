class CreateDocVotes < ActiveRecord::Migration
  def change
    create_table :doc_votes do |t|
      t.belongs_to :doc
      t.belongs_to :user
      t.integer :value

      t.timestamps
    end
    add_index :doc_votes, :doc_id
    add_index :doc_votes, :user_id
  end
end