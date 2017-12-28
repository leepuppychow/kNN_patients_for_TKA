require 'rails_helper'
require 'csv'

describe "When user visits patient index page" do
  context "user can click on link for New Patient Info" do
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
    it "will be redirected to a new page with form to enter patient data" do
      visit patients_path

      click_on "New Patient Info"

      expect(current_path).to eq new_patient_path
      expect(page).to have_content "Add New Patient Information"
    end

    it "can then fill in form and then click on link Make Patient Prediction" do
      visit patients_path

      click_on "New Patient Info"

      fill_in "k", with: 5
      fill_in "patient[age]", with: 55
      fill_in "patient[pain_level]", with: 7
      fill_in "patient[bodyweight]", with: 225
      fill_in "patient[knee_AROM]", with: 95

      click_on "Make Prediction"

      expect(page).to have_content "Patient recommended for TKA? => Yes"
    end
  end
end
