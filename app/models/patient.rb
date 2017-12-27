class Patient < ApplicationRecord
  validates :age,
            :pain_level,
            :bodyweight,
            :knee_AROM,
            :classification,
            :distance_to_unknown, presence: true  
end
