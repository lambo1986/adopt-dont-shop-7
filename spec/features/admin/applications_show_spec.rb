require "rails_helper"

RSpec.describe "the admin applications show page", type: :feature do
  describe "when logged in as an admin" do
    it "lists all the pets on the application and allows to approve" do
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

    it "lists all the pets on the application and allows to reject" do
      shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
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

    it "shows a different application with the same pets and those pets haven't been approved or rejected" do
      shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
      pet_1 = shelter_1.pets.create!(name: "garfield", breed: "shorthair", adoptable: false, age: 1)
      pet_2 = shelter_2.pets.create!(name: "fido", breed: "mutt", adoptable: false, age: 2)
      application1 = Application.create!(name: "Fred Flintstone", address: "123 Main St, city: New York, state: NY, zip: 70117", description: "Worked with dinosaurs", status: "Pending")
      application2 = Application.create!(name: "Barney", address: "5 Rock St, city: Cave Junction, state: NE, zip: 93210", description: "Worked with Fred Flintstone", status: "Pending")

      application1.pets << [pet_1, pet_2]
      application2.pets << [pet_1, pet_2]

      visit "/admin/applications/#{application1.id}"

      expect(page).to have_button("Reject #{pet_1.name}!")
      expect(page).to have_button("Reject #{pet_2.name}!")
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_2.name)

      click_button "Reject #{pet_1.name}!"
      expect(current_path).to eq("/admin/applications/#{application1.id}")

      expect(page).to_not have_button("Reject #{pet_1.name}!")
      expect(page).to have_button("Reject #{pet_2.name}!")

      visit "/admin/applications/#{application2.id}"

      expect(page).to have_button("Reject #{pet_1.name}!")
      expect(page).to have_button("Reject #{pet_1.name}!")
      expect(page).to have_button("Approve #{pet_2.name}!")
      expect(page).to have_button("Approve #{pet_2.name}!")
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_2.name)
    end
  end
end
