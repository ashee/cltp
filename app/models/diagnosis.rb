class Diagnosis < ActiveRecord::Base
  set_table_name :dx
  belongs_to :clerkship
  belongs_to :category, :foreign_key => 'category_id', :class_name => 'DiagnosisCategory'
  has_many :encounter_diagnoses, :foreign_key => 'dx_id', :class_name => 'EncounterDiagnosis'
end