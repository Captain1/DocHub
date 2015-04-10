class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :rec_id
      t.integer :message_id
      t.string :status

      t.timestamps null: false
    end
  end
end
