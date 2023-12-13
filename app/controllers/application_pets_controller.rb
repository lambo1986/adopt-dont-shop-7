class ApplicationPetsController < ApplicationController

  def update
    @application = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])

    unless @application.pets.include?(pet)
      @application.pets << pet
    end
      redirect_to "/applications/#{@application.id}"
  end
end
