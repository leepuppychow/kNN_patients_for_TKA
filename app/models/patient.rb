class Patient < ApplicationRecord
  validates :age, :pain_level, :bodyweight, :knee_AROM, presence: true  

end
