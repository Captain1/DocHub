class DocComment < ActiveRecord::Base
  has_many :doc_replies ,dependent: :destroy
  belongs_to :doc, counter_cache: true
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 300 } 
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                            WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",user_id: user.id)
  end
end

