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

  def self.calculate_all_distances_from(unknown)
    all.each do |patient|
      patient.find_distance_to(unknown)
      patient.save
    end
  end

  def self.find_kNN(k)
    order(:distance_to_unknown).limit(k)
  end

  def self.classify_unknown(unknown, k)
    calculate_all_distances_from(unknown)
    neighbors = find_kNN(k).pluck(:classification)
    
    if neighbors.count("Yes") > neighbors.count("No")
      "Yes"
    else
      "No"
    end

    # x = find_by_sql("SELECT classification, COUNT(classification) FROM
    #             (SELECT * FROM patients ORDER BY distance_to_unknown LIMIT 3) AS foo
    #             GROUP BY classification")

    # group(:classification, :distance_to_unknown).order(:distance_to_unknown).limit(k).count
  end

end
