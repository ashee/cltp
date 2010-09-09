class Encounter < ActiveRecord::Base
  belongs_to :clerkship
  belongs_to :clinic
  has_many :diagnoses, :class_name => 'EncounterDiagnosis'
  has_many :procedures, :class_name => 'EncounterProcedure'
  belongs_to :creator, :class_name => 'User', :foreign_key => 'created_by'
  belongs_to :updater, :class_name => 'User', :foreign_key => 'updated_by'
  
  # e = Encounter.find 1
  # e.diagnoses (looks up encounter_dx table for associated rows)
  
end
