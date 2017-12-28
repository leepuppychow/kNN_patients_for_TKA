require 'csv'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Patient.destroy_all

patients = CSV.open("./lib/seeds/kNN_patients.csv", headers: true).readlines

patients.each do |patient|
  Patient.create!(age: patient["age"],
                  pain_level: patient["pain_level"],
                  bodyweight: patient["bodyweight"],
                  knee_AROM: patient["knee_AROM"],
                  classification: patient["classification"],
                  distance_to_unknown: patient["distance_to_unknown"])
end

puts "db populated with #{Patient.count} patients"
