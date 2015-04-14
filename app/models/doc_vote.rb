class DocVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :doc  

  validates_uniqueness_of :doc_id, scope: :user_id
  validates_inclusion_of :value, in: [1, -1]
  validate :ensure_not_author

  def ensure_not_author
    errors.add :user_id, "is the author of the doc" if doc.user_id == user_id
  end
end


