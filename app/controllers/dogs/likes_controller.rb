class Dogs::LikesController < ApplicationController
  before_action :set_dog, only: [:create]

  def create
    if !@dog.users_dog?(current_user.id) && !@dog.user_liked?(current_user.id)
      @dog.dog_likes.create(user_id: current_user.id)

      redirect_to dog_path @dog, notice: 'Dog was successfully liked.'
    else
      redirect_to dog_path @dog, notice: 'Failed to like dog.'
    end
  end

  private

  def set_dog
    @dog = Dog.find(params[:dog_id])
  end
end