class AddIndexToDocs < ActiveRecord::Migration
  def change
    add_index :docs, :user_id
  end
end
