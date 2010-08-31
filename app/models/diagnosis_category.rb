class DiagnosisCategory < ActiveRecord::Base
  set_table_name :dx_categories
  belongs_to :clerkship
  has_many :diagnoses, :class_name => 'Diagnosis', :foreign_key => 'category_id'
end