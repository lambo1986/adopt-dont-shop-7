class Admin::ApplicationsController < ApplicationController
  def show
    @applications = Application.all
    @application = Application.find(params[:id])
    @pets = @application.pets
    @commit_param = params[:commit]
  end

  def update
    @applications = Application.all
    @application = Application.find(params[:id])
    @pets = @application.pets
    @commit_param = params[:commit]
    @pet_application = ApplicationPet.find_by(application_id: @application.id)
    if @commit_param.nil?
      @fresh_pets = []
      fresh_pet = @pets.find_by(adoptable: false)
      fresh_pet.update!(adoptable: false, rejected: false) if fresh_pet
      @fresh_pets << fresh_pet
    elsif @commit_param.starts_with?('Approve')
      approved_pet = @pets.find_by(adoptable: false)
      approved_pet.update!(adoptable: true, rejected: false) if approved_pet
      redirect_to "/admin/applications/#{@application.id}"
    elsif @commit_param.starts_with?('Reject')
      rejected_pet = @pets.find_by(adoptable: false)
      rejected_pet.update!(adoptable: false, rejected: true) if rejected_pet
      redirect_to "/admin/applications/#{@application.id}"
    end
  end
end
