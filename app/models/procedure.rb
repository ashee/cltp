class Procedure < ActiveRecord::Base
  belongs_to :clerkship
  has_many :encounter_procedures, :class_name => 'EncounterProcedure'
end