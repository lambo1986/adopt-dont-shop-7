require "rails_helper"

RSpec.describe "the admin applications show page", type: :feature do
  describe "when logged in as an admin" do
    xit "lists all the pets on the application and allows to approve" do
      shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      shelter_2 = Shelter.create!(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
      pet_1 = shelter_1.pets.create!(name: "garfield", breed: "shorthair", adoptable: false, age: 1)
      pet_2 = shelter_2.pets.create!(name: "fido", breed: "mutt", adoptable: false, age: 2)
      application = Application.create!(name: "Fred Flintstone", address: "123 Main St, city: New York, state: NY, zip: 70117", description: "Worked with dinosaurs", status: "Pending")

      application.pets << [pet_1, pet_2]

      visit "/admin/applications/#{application.id}"

      expect(page).to have_button("Approve #{pet_1.name}!")
      expect(page).to have_button("Approve #{pet_2.name}!")
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_2.name)

      click_button "Approve #{pet_1.name}!"
      expect(current_path).to eq("/admin/applications/#{application.id}")

      expect(page).to_not have_button("Approve #{pet_1.name}!")
      expect(page).to have_button("Approve #{pet_2.name}!")
    end

    xit "lists all the pets on the application and allows to reject" do
      shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      shelter_2 = Shelter.create!(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
      pet_1 = shelter_1.pets.create!(name: "garfield", breed: "shorthair", adoptable: false, age: 1)
      pet_2 = shelter_2.pets.create!(name: "fido", breed: "mutt", adoptable: false, age: 2)
      application = Application.create!(name: "Fred Flintstone", address: "123 Main St, city: New York, state: NY, zip: 70117", description: "Worked with dinosaurs", status: "Pending")

      application.pets << [pet_1, pet_2]

      visit "/admin/applications/#{application.id}"

      expect(page).to have_button("Reject #{pet_1.name}!")
      expect(page).to have_button("Reject #{pet_2.name}!")
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_2.name)

      click_button "Reject #{pet_1.name}!"
      expect(current_path).to eq("/admin/applications/#{application.id}")

      expect(page).to_not have_button("Reject #{pet_1.name}!")
      expect(page).to have_button("Reject #{pet_2.name}!")
    end

    it "approves a pet on one application without affecting the other" do
      shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      pet_1 = shelter_1.pets.create!(name: "garfield", breed: "shorthair", adoptable: false, age: 1)
      application_1 = Application.create!(name: "Fred Flintstone", address: "123 Main St, city: New York, state: NY, zip: 70117", description: "Worked with dinosaurs", status: "Pending")
      application_2 = Application.create!(name: "Jon Arbuckle", address: "321 Beta St, city: Old Jersey, state: OJ, zip: 77777", description: "Loves lasagna", status: "Pending")

      application_1.pets << [pet_1]
      application_2.pets << [pet_1]
      # ApplicationPet status is nil...changed migration to default to "Pending"
# require 'pry'; binding.pry
      # When I visit the admin application show page for one of the applications
      visit "/admin/applications/#{application_1.id}"
      # save_and_open_page
      expect(page).to have_button("Approve #{pet_1.name}!")
      expect(page).to have_button("Reject #{pet_1.name}!")

      # And I approve or reject the pet for that application
      click_button "Approve #{pet_1.name}!"
      # require 'pry'; binding.pry
      # save_and_open_page
      expect(page).to have_content("Pet Approved")
      
      # When I visit the other application's admin show page
      visit "/admin/applications/#{application_2.id}"
      save_and_open_page
      # Then I do not see that the pet has been accepted or rejected for that application
      # And instead I see buttons to approve or reject the pet for this specific application
      expect(page).to have_button("Approve #{pet_1.name}!")
      expect(page).to have_button("Reject #{pet_1.name}!")


    end
  end
end
