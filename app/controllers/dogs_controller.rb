class DogsController < ApplicationController
  before_action :set_dog, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :update]

  DOGS_PER_PAGE = 5

  # GET /dogs
  # GET /dogs.json
  def index
    @page = params.fetch(:page, 0).to_i

    if params["sort"] == "recent_likes"
      @dogs = Dog.order_by_recent_likes.offset(@page * DOGS_PER_PAGE).limit(DOGS_PER_PAGE)
    else
      @dogs = Dog.offset(@page * DOGS_PER_PAGE).limit(DOGS_PER_PAGE)
    end
  end

  # GET /dogs/1
  # GET /dogs/1.json
  def show
  end

  # GET /dogs/new
  def new
    @dog = Dog.new
  end

  # GET /dogs/1/edit
  def edit
  end

  # POST /dogs
  # POST /dogs.json
  def create
    @dog = Dog.new(dog_params.merge({user: current_user}))

    respond_to do |format|
      if @dog.save
        @dog.images.attach(params[:dog][:image]) if params[:dog][:image].present?

        format.html { redirect_to @dog, notice: 'Dog was successfully created.' }
        format.json { render :show, status: :created, location: @dog }
      else
        format.html { render :new }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dogs/1
  # PATCH/PUT /dogs/1.json
  def update
    if current_user == @dog.user
      respond_to do |format|
        if @dog.update(dog_params)
          @dog.images.attach(params[:dog][:image]) if params[:dog][:image].present?

          format.html { redirect_to @dog, notice: 'Dog was successfully updated.' }
          format.json { render :show, status: :ok, location: @dog }
        else
          format.html { render :edit }
          format.json { render json: @dog.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /dogs/1
  # DELETE /dogs/1.json
  def destroy
    @dog.destroy
    respond_to do |format|
      format.html { redirect_to dogs_url, notice: 'Dog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dog
    @dog = Dog.includes(:dog_likes).find_by(id: params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def dog_params
    params.require(:dog).permit(:name, :description, images: [])
  end
end
