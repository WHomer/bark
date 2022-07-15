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
end
