class AddDocCommentsCountToDocs < ActiveRecord::Migration
  def change
    add_column :docs, :doc_comments_count, :integer, :default => 0
  end
end
