class DocCommentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :content
  has_many :doc_replies
end
