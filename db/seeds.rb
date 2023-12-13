# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

ApplicationPet.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all

  aurora_shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
  rgv_animal_shelter = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
  fancy_pets_colorado = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

  mr_pirate = aurora_shelter.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
  clawdia = aurora_shelter.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
  lucille_bald = fancy_pets_colorado.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
  ann = aurora_shelter.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)

  john = Application.create(name: "John", address: "123 makebelieve dr, city: fakesville, state: NA, zip_code: 12345", description: "I need a companion!", status: "Pending")
  jessica = Application.create(name: "Jessica", address: "123 makebelieve dr, city: fakesville, state: NA, zip_code: 12345", description: "I need a companion!", status: "Pending")
  craig = Application.create(name: "Craig", address: "123 makebelieve dr, city: fakesville, state: NA, zip_code: 12345", description: "I need a companion!", status: "In Progress")
  hope = Application.create(name: "Hope", address: "123 makebelieve dr, city: fakesville, state: NA, zip_code: 12345", description: "I need a companion!", status: "In Progress")

  pet_app_1 = ApplicationPet.create!(application_id: "#{john.id}", pet_id: "#{lucille_bald.id}", status: "Pending")
  pet_app_2 = ApplicationPet.create!(application_id: "#{jessica.id}", pet_id: "#{mr_pirate.id}", status: "Pending")
  pet_app_3 = ApplicationPet.create!(application_id: "#{craig.id}", pet_id: "#{lucille_bald.id}", status: "Pending")
  pet_app_4 = ApplicationPet.create!(application_id: "#{hope.id}", pet_id: "#{clawdia.id}", status: "Pending")

  vet_office_1 = VeterinaryOffice.create(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
  vet_office_2 = VeterinaryOffice.create(name: 'Vets R Us', boarding_services: true, max_patient_capacity: 20)

  not_on_call_vet = Veterinarian.create(name: 'Sam', review_rating: 10, on_call: false, veterinary_office_id: vet_office_1.id)
  vet_1 = Veterinarian.create(name: 'Taylor', review_rating: 10, on_call: true, veterinary_office_id: vet_office_1.id)
  vet_2 = Veterinarian.create(name: 'Jim', review_rating: 8, on_call: true, veterinary_office_id: vet_office_1.id)
  vet_3 = Veterinarian.create(name: 'Sarah', review_rating: 9, on_call: true, veterinary_office_id: vet_office_2.id)
