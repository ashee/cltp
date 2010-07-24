class AddFieldsToEncounters < ActiveRecord::Migration
  def self.up
    add_column :encounters, :procedures_performed, :string
    add_column :encounters, :procedures_observed, :string
    add_column :encounters, :history_taken, :boolean
    add_column :encounters, :physical_exam_taken, :boolean
    add_column :encounters, :notes, :text
    add_column :encounters, :site, :string
  end

  def self.down
    remove_column :encounters, :site
    remove_column :encounters, :notes
    remove_column :encounters, :physical_exam_taken
    remove_column :encounters, :history_taken
    remove_column :encounters, :procedures_observed
    remove_column :encounters, :procedures_performed
  end
end
