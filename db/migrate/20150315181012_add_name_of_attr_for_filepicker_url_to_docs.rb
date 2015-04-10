class AddNameOfAttrForFilepickerUrlToDocs < ActiveRecord::Migration
  def change
    add_column :docs, :filepicker_url, :string
  end
end
