class Doc < ActiveRecord::Base
    validates :title, :topic, :license, :description, presence: true; 
    validates :title, length: { maximum: 50 }
    validates :description, presence: true, length: { maximum: 300 }
    
    belongs_to :user
    belongs_to :favorite_docs
    has_many :doc_comments ,dependent: :destroy
    has_many :doc_votes
    # has_many :related_docs ,dependent: :destroy
    # has_many :topics ,dependent: :destroy

    # default_scope {order('docs.created_at DESC')}
    scope :recent, ->{ order("created_at DESC")}
    scope :active, ->{ where("doc_comments_count >= ?", 5)}
    scope :zeroviews, ->{ where(doc_comments_count: 0)}

    LICENSES = ['All Rights Reserved', 'CC Attribution License', 'CC Attribution-NoDerivs License', 
        'CC Attribution-NonCommercial License','CC Attribution-NonCommercial-NoDerivs License',
        'CC Attribution-NonCommercial-ShareAlike License','CC Attribution-ShareAlike License']

    TOPICS = ['Front End','Back End', 'Web Service', 'Database','Javascript','Linux','Java', 'Version Control','Ruby','Mobile Development', 'UI/UX Design','Cloud Computing','Virtualization']
    def self.by_votes
        select('docs.*, coalesce(value, 0) as votes').
        joins('left join doc_votes on doc_id=docs.id').
        order('votes desc')
    end
    def votes
        read_attribute(:votes) || doc_votes.sum(:value)
    end
    # sqlite3 search
    def self.search(query)
        where("title like ?", "%#{query}%") 
    end
end