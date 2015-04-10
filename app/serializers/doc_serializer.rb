class DocSerializer < ActiveModel::Serializer
  attributes :id, :user_id,:title, :topic, :license, :description, :filepicker_url
  has_many :doc_comments
end
