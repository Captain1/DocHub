class DocReply < ActiveRecord::Base  
belongs_to :doc_comment
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 300 } 
end