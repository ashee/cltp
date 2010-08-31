class Diagnosis < ActiveRecord::Base
  set_table_name :dx
  belongs_to :clerkship
  belongs_to :category, :foreign_key => 'category_id', :class_name => 'DiagnosisCategory'
end