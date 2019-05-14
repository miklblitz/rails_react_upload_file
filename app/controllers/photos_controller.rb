class PhotosController < ApplicationController
  include JSONErrors
  
  #Index action, photos gets listed in the order at which they were created
 def index
  @photos = Photo.order('created_at')
 end

 #New action for creating a new photo
 def new
  @photo = Photo.new
 end

 #Create action ensures that submitted photo gets created if it meets the requirements
 def create
  if photo_params.permitted?
    @photo = Photo.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { flash[:notice] = "Successfully added new photo!";redirect_to root_path }
        format.json { render json: [], status: :created }
      else
        format.html { flash[:alert] = "Error adding new photo!";render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  else
    format.json { render json: @article.errors, status: :unprocessable_entity }
  end
 end

 private

 #Permitted parameters when creating a photo. This is used for security reasons.
 def photo_params
  params.require(:photo).permit(:title, :image)
 end

end
