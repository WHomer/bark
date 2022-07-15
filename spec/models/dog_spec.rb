require 'rails_helper'

RSpec.describe Dog, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :dog_likes }
  end

  it 'user_liked?' do
    user_1 = create(:user)
    user_2 = create(:user)
    dog = create(:dog, user: user_1)
    dog.dog_likes.create(user: user_1)

    expect(dog.user_liked?(user_1.id)).to eq(true)
    expect(dog.user_liked?(user_2.id)).to eq(false)
  end

  it 'user_dog?' do
    user_1 = create(:user)
    user_2 = create(:user)
    dog = create(:dog, user: user_1)

    expect(dog.users_dog?(user_1.id)).to eq(true)
    expect(dog.users_dog?(user_2.id)).to eq(false)
  end

  it 'order_by_recent_likes' do
    user_1 = create(:user)
    user_2 = create(:user)
    user_3 = create(:user)
    dog_1 = create(:dog, user: user_1)
    dog_2 = create(:dog, user: user_1)
    dog_3 = create(:dog, user: user_2)
    dog_4 = create(:dog, user: user_3)
    DogLike.create(dog: dog_3, user: user_1)
    DogLike.create(dog: dog_3, user: user_3)
    DogLike.create(dog: dog_1, user: user_3)
    DogLike.create(dog: dog_2, user: user_3, created_at: 2.hours.ago)
    DogLike.create(dog: dog_2, user: user_2, created_at: 2.hours.ago)

    expect(Dog.order_by_recent_likes).to eq([dog_3, dog_1, dog_2, dog_4])    
  end
end
