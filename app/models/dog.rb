class Dog < ApplicationRecord
  has_many_attached :images
  has_many :dog_likes, dependent: :destroy
  belongs_to :user

  def user_liked?(user_id)
    dog_likes.where(user_id: user_id).exists?
  end

  def users_dog?(user_id)
    user.id == user_id
  end

  def self.order_by_recent_likes
    joins("LEFT OUTER JOIN (SELECT dog_id, COUNT(*) AS like_count
           FROM dog_likes
           WHERE created_at > '#{1.hours.ago}'
           GROUP BY dog_id) AS temp_likes ON temp_likes.dog_id = dogs.id")
      .select('dogs.*, COALESCE(temp_likes.like_count, 0) AS like_count')
      .order('like_count DESC')
  end
end
