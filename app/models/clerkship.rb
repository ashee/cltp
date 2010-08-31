class Clerkship < ActiveRecord::Base
  # has_many :encounters
  has_many :diagnosis_categories
  has_many :diagnoses
end
