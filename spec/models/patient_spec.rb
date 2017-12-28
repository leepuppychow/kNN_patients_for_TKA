require 'rails_helper'

describe Patient, type: :model do
  describe "Validations" do
    it {is_expected.to validate_presence_of(:age)}
    it {is_expected.to validate_presence_of(:pain_level)}
    it {is_expected.to validate_presence_of(:bodyweight)}
    it {is_expected.to validate_presence_of(:knee_AROM)}
    it {is_expected.to validate_presence_of(:classification)}
    it {is_expected.to validate_presence_of(:distance_to_unknown)}
  end

  describe "Instance Methods" do
    it "can calculate Euclidean distance between two patients" do
      patient = create(:patient)
      unknown = build(:patient, age: 59, pain_level: 9)

      patient.find_distance_to(unknown)
      expect(patient.distance_to_unknown).to eq 5.0
    end
  end

  describe "Class Methods" do
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

    it "can calculate the distance to unknown for all patients in database" do
      unknown = build(:patient, age: 59, pain_level: 9)

      Patient.calculate_all_distances_from(unknown)

      expect(Patient.sum(:distance_to_unknown)).to_not eq 0
      expect(Patient.sum(:distance_to_unknown)).to eq 1224.29
    end

    it "can find the k-Nearest Neighbors" do
      unknown = build(:patient, age: 59, pain_level: 9)

      Patient.calculate_all_distances_from(unknown)

      expect(Patient.find_kNN(3).count).to eq 3
      expect(Patient.find_kNN(3).first.distance_to_unknown).to eq 5.48
      expect(Patient.find_kNN(3).last.distance_to_unknown).to eq 12.88
    end

    it "can classify unknown patient" do
      unknown = build(:patient, age: 59, pain_level: 9)

      expect(Patient.classify_unknown(unknown, 3)).to eq "No"
    end
  end
end
