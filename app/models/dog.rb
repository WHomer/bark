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
end
