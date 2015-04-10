class CreateMessageTexts < ActiveRecord::Migration
  def change
    create_table :message_texts do |t|
      t.integer :user_id
      t.integer :sender_id
      t.text :message
      t.string :type
      t.integer :group_id

      t.timestamps null: false
    end
  end
end
