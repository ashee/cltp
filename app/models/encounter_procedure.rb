class EncounterProcedure < ActiveRecord::Base
  belongs_to :encounter
  belongs_to :procedure
  belongs_to :creator, :class_name => 'User', :foreign_key => 'created_by'
  belongs_to :updater, :class_name => 'User', :foreign_key => 'updated_by'
end