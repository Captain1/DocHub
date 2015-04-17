class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
  has_many :docs
  has_many :doc_comments
  has_many :doc_replies
end
