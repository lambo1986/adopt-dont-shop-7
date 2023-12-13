class AddStatusToApplicationPets < ActiveRecord::Migration[7.0]
  def change
    add_column :application_pets, :approved, :boolean, default: false
    add_column :application_pets, :rejected, :boolean, default: false
  end
end
