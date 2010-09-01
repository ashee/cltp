class EncounterDiagnosis < ActiveRecord::Base
  set_table_name :encounter_dx
  belongs_to :encounter
  belongs_to :diagnosis, :class_name => 'Diagnosis', :foreign_key => 'dx_id'
  
  def is_primary?
    self.dx_type == 'P'
  end
  
  def is_secondary?
    self.dx_type  == 'S'
  end
  
end