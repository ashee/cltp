class Clerkship < ActiveRecord::Base
  # has_many :encounters
  has_many :diagnosis_categories
  has_many :diagnoses
  has_many :procedures
  has_many :compliance_requirements
end
