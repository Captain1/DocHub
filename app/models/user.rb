class User < ActiveRecord::Base
      has_many :microposts, dependent: :destroy
      has_many :docs, dependent: :destroy
      has_many :doc_comments, dependent: :destroy
      has_many :doc_replies, dependent: :destroy
      has_many :messages, dependent: :destroy
      has_many :message_texts, dependent: :destroy
      has_many :relationships, foreign_key: "follower_id", dependent: :destroy
   
      has_many :followed_users, through: :relationships, source: :followed
      has_many :reverse_relationships, foreign_key: "followed_id",
                                     class_name:  "Relationship",
                                     dependent:   :destroy
      has_many :followers, through: :reverse_relationships, source: :follower
      has_many :favorites
      has_many :favorite_docs, through: :favorites, source: :favorited, source_type: 'Doc'
      
      before_save do |user| 
              user.email = email.downcase 
            user.remember_token = SecureRandom.urlsafe_base64
            end
      validates :name, presence: true, length: { maximum: 50 }
      VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      validates :email, presence: true, 
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
      validates :password, presence: true, length: { minimum: 6 }
      validates :password_confirmation, presence: true
      has_secure_password
      def feed
         Micropost.from_users_followed_by(self)
      end

      def doc_feed
        DocComment.from_users_followed_by(self)
      end 
      
      def following?(other_user)
        relationships.find_by(followed_id: other_user.id)
      end
      
      def follow!(other_user)
        relationships.create!(followed_id: other_user.id)
      end
      
      def unfollow!(other_user)
        relationships.find_by(followed_id: other_user.id).destroy
      end
end
