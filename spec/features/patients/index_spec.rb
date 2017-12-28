require 'rails_helper'
require 'csv'

describe "When a user visits the patients index path" do
  before(:each) do
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
  end

  it "will see an index of all the training data for patients" do
    visit patients_path

    expect(page).to have_content "Training Data: All Patients"
  end
end
