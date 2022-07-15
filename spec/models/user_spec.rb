require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many :dogs }
    it { should have_many :dog_likes }
  end
end