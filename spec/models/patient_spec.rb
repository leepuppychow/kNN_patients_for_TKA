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
end
