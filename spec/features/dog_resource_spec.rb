require 'rails_helper'

describe 'Dog resource', type: :feature do
  describe 'As a User' do
    before :each do
      @user_1 = create(:user)
      allow_any_instance_of(DogsController).to receive(:authenticate_user!).and_return(true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
    end

    it 'can create a profile' do
      visit new_dog_path
      fill_in 'Name', with: 'Speck'
      fill_in 'Description', with: 'Just a dog'
      attach_file 'dog_images', 'spec/fixtures/images/speck.jpg'
      click_button 'Create Dog'
      expect(Dog.count).to eq(1)
    end

    it 'can edit a dog profile' do
      dog = create(:dog, user: @user_1)
      visit edit_dog_path(dog)
      fill_in 'Name', with: 'Speck'
      click_button 'Update Dog'
      expect(dog.reload.name).to eq('Speck')
    end
  end

  describe 'As a Visitor' do
    it 'can not create a profile' do
      visit new_dog_path
      expect(page).to have_content('You must be logged in to add a new dog.')
      expect(page).to_not have_button("Create Dog")
      expect(Dog.count).to eq(0)
    end

    it 'can not edit a dog profile' do
      dog = create(:dog, name:'Ace')
      visit edit_dog_path(dog)
      fill_in 'Name', with: 'Speck'
      click_button 'Update Dog'
      expect(dog.reload.name).to eq('Ace')
      expect(dog.reload.name).to_not eq('Speck')
    end
  end

  it 'can delete a dog profile' do
    dog = create(:dog)
    visit dog_path(dog)
    click_link "Delete #{dog.name}'s Profile"
    expect(Dog.count).to eq(0)
  end
end
