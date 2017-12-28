class Patient < ApplicationRecord
  validates :age,
            :pain_level,
            :bodyweight,
            :knee_AROM,
            :classification,
            :distance_to_unknown, presence: true

  def find_distance_to(unknown)
    self.distance_to_unknown = Math.sqrt(
      (age - unknown.age) ** 2 +
      (pain_level - unknown.pain_level) ** 2 +
      (bodyweight - unknown.bodyweight) ** 2 +
      (knee_AROM - unknown.knee_AROM) ** 2)
  end
end
